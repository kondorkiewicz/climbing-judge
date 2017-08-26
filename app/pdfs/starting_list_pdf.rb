class StartingListPdf < Prawn::Document
  
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
    text "#{@list.event.name}, #{@list.name} starting list", size: 18, style: :bold
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
    [["Start Number", "Full Name", "Club"]] +
    @list.scores.sort_by { |score| score.start_number }.map do |score|
      [score.start_number, score.competitor.name + " " + score.competitor.surname, score.competitor.club]
    end
  end
end