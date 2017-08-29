require 'exceptions'

class Event < ApplicationRecord
  include Exceptions
  validates :name, presence: true
  belongs_to :user
  has_many :lists, dependent: :destroy  
  has_many :eliminations_results, dependent: :destroy 
  has_many :results, dependent: :destroy 
  has_and_belongs_to_many :competitors
  
  def men 
    competitors.where(sex: 'M')
  end
  
  def women 
    competitors.where(sex: 'F')
  end
  
  def eliminations_lists
    lists.where("round = ? OR round = ?", "el_1", "el_2")
  end
  
  def finals_lists(round) 
    lists.where(round: round)
  end
  
  def round_scores(round) 
    list(round, 'M').scores + list(round, 'F').scores
  end
  
  def list(round, sex)
    lists.where("round = ? AND sex = ?", round, sex).take
  end
  
  def list_scores(round, sex)
    lists.where("round = ? AND sex = ?", round, sex).take.scores.sort_by { |score| score.start_number }
  end
  
  def create_eliminations_lists
    if men.empty? || women.empty?
      raise Exceptions::ClimbingError.new('There has to be at least one competitor in each category!')
    elsif !eliminations_lists.empty?
      raise Exceptions::ClimbingError.new('Eliminations lists for that event already exist!')
    end
    m1 = create_first_list(men)
    f1 = create_first_list(women)
    create_second_list('M')
    create_second_list('F')
  end 
  
  def create_first_list(competitors)
    sex = competitors.first.sex 
    sex == 'M' ? name = "First route (men)" : name = "First route (women)"
    list = List.create(event_id: id, round: 'el_1', sex: sex, name: name)
    competitors.shuffle 
    competitors.each.with_index(1).map do |competitor, start_number|
      list.scores << Score.create(competitor_id: competitor.id, start_number: start_number, score: 0)
    end
    list
  end
  
  def create_second_list(sex)
    first_list_scores = list_scores('el_1', sex)
    sex == 'M' ? name = "Second route (men)" : name = "Second route (women)"
    list = List.create(event_id: id, round: 'el_2', sex: sex, name: name)
    half = first_list_scores.size / 2 + 1
    first_list_scores.size.even? ? start_number = half : start_number = half + 1 
    first_list_scores.each.with_index(1) do |score, i|
      start_number = 1 if i == half
      list.scores << Score.create(competitor_id: score.competitor_id, start_number: start_number, score: 0)
      start_number += 1 
    end
  end 
  
  def create_finals_list(sex, comps_number)
    comps_number == 8 ? round = 'f' : round = 'sf'
    if list(round, sex).nil? && eliminations_lists.empty?
      raise StandardError.new('There are no scores in previous round!')
    end
    if status == 'semi_finals' && round_scores('sf').any? { |score| score.score == 0 }
      raise StandardError.new('Every score has to be greater than zero!')
    end 
    status == "semi_finals" ? results = list_scores('sf', sex) : results = eliminations_results.sex(sex)
    finalists = select_competitors(results, comps_number)
    set_starting_numbers(finalists, round, sex)
  end
  
  def select_competitors(results, comps_number)
    if results.size <= comps_number
      results 
    else 
      results.select do |comp| 
        comp.place <= results[comps_number].place
      end
    end  
  end
  
  def set_starting_numbers(finalists, round, sex)
    name = define_name(round, sex) 
    list = List.create(event_id: id, round: round, sex: sex, name: name)
    finalists.sort_by { |finalist| finalist.place }.reverse.each.with_index(1).map do |finalist, i| 
      list.scores << Score.create(competitor_id: finalist.competitor_id, start_number: i, score: 0)
    end
    list
  end
  
  def define_name(round, sex)
     sex == 'M' ? part = "(men)" : part = "(women)"
     round == 'f' ? name = "Finals #{part}" : name = "Semi-Finals #{part}"
  end
  
end
