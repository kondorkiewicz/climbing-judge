class EliminationsResultsPdf < Prawn::Document
  
  def initialize(results, sex)
    super(top_margin: 70) 
    @results = results
    font_families.update("DejaVuSans" => {
      :normal => "app/assets/fonts/DejaVuSans.ttf",
      :bold => "app/assets/fonts/DejaVuSans-Bold.ttf"
    })
    font "DejaVuSans"
    results_title(sex)
    eliminations_results
  end
  
  def results_title(sex) 
    text "#{@results[0].event.name} - Eliminations Results (#{sex})", size: 20, style: :bold
  end 
  
  def eliminations_results 
    move_down 20
    table results_rows do 
      row(0).font_style = :bold
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
  end 
  
  def results_rows
    [["Place", "Full Name", "1-st Route", "2-nd Route", "Points"]] +
    @results.sort_by { |result| result.place }.map do |result|
      [result.place, result.competitor.name + " " + result.competitor.surname, result.first_route_place, 
      result.second_route_place, result.points.round(2)]
    end
  end
end