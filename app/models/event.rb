class Event < ApplicationRecord
  validates :name, presence: true
  belongs_to :user
  has_many :lists, dependent: :destroy
  has_many :eliminations_results, dependent: :destroy
  has_many :results, dependent: :destroy
  has_and_belongs_to_many :participants, foreign_key: "competitor_id",
                                         class_name: "Competitor",
                                         join_table: "competitors_events",
                                         association_foreign_key: "event_id"

  def men
    participants.where(sex: 'M')
  end

  def women
    participants.where(sex: 'F')
  end

  def eliminations_lists
    lists.where("round = ? OR round = ?", "first_route", "second_route")
  end

  def round_lists(round)
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
    m1 = create_first_list(men)
    f1 = create_first_list(women)
    create_second_list(m1)
    create_second_list(f1)
  end

  def create_first_list(competitors)
    competitors.first.sex == 'M' ? sex = 'men' : sex = 'women'
    list = List.create(event_id: id, round: 'first_route', sex: sex)
    competitors.shuffle
    competitors.each.with_index(1).map do |competitor, start_number|
      list.scores.create(competitor_id: competitor.id, start_number: start_number, score: 0)
    end
    list
  end

  def create_second_list(first_list)
    list = List.create(event_id: id, round: 'second_route', sex: first_list.sex)
    half = first_list.scores.size / 2 + 1
    first_list.scores.size.even? ? start_number = half : start_number = half + 1
    first_list.scores.each.with_index(1) do |score, i|
      start_number = 1 if i == half
      list.scores.create(competitor_id: score.competitor_id, start_number: start_number, score: 0)
      start_number += 1
    end
  end

  def create_semi_finals_list(sex)
    sex == 'men' ? comp_sex = 'M' : comp_sex = 'F'
    results = eliminations_results.sex(comp_sex)
    competitors = select_competitors(results, 26)
    create_list(competitors, 'semi_finals', sex)
  end

  def create_finals_list(sex)
    if status == "semi_finals"
      results = list_scores('semi_finals', sex)
    else
      sex == 'men' ? comp_sex = 'M' : comp_sex = 'F'
      results = eliminations_results.sex(comp_sex)
    end
    competitors = select_competitors(results, 8)
    create_list(competitors, 'finals', sex)
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

  def create_list(comps, round, sex)
    list = List.create(event_id: id, round: round, sex: sex)
    comps.sort_by { |comp| comp.place }.reverse.each.with_index(1).map do |comp, i|
      list.scores.create(competitor_id: comp.competitor_id, start_number: i, score: 0)
    end
  end

end
