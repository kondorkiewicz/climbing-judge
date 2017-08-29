class ListsController < ApplicationController
  
  def show
    @list = List.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do 
        if params[:type]
          pdf = ResultsListPdf.new(@list)
        else 
          pdf = StartingListPdf.new(@list)
        end 
        send_data pdf.render, filename: "list_#{@list.id}.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end 
    end 
  end 
  
end 