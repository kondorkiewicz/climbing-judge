class ResultsListPdf < Prawn::Document
  
  def initialize(list)
    super(top_margin: 70) 
    @list = list
    font_families.update("DejaVuSans" => {
      :normal => "app/assets/fonts/DejaVuSans.ttf",
      :bold => "app/assets/fonts/DejaVuSans-Bold.ttf"
    })
    font "DejaVuSans"
    list_title
    scores
  end
  
  def list_title 
    text "#{@list.event.name}, #{@list.name} results", size: 20, style: :bold
  end 
  
  def scores 
    move_down 20
    table scores_rows do 
      row(0).font_style = :bold
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
  end 
  
  def scores_rows
    [["Place", "Full Name", "Club", "Score", "Points"]] +
    @list.scores.sort_by { |score| score.place }.map do |score|
      [score.place, score.competitor.full_name, score.competitor.club, score.score, score.ex_points]
    end
  end
end