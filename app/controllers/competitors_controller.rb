class CompetitorsController < ApplicationController

  def index
    @competitors = Competitor.all
    @men = Competitor.sex('M')
    @women = Competitor.sex('F')
  end

  def show
    @competitor = Competitor.find(params[:id])
    @results = Result.where(competitor_id: @competitor.id)
  end

  def create
    @competitor = Competitor.new(competitor_params)
    respond_to do |format|
      if @competitor.save
        format.html { redirect_to competitors_path }
        format.json { render :show, status: :created, location: @competitor }
      else
        format.html { render 'new', locals: { competitor: @competitor } }
        format.json { render json: @competitor.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @competitor = Competitor.new
  end

  private

  def competitor_params
    params.require(:competitor).permit(:name, :surname, :birth_date, :sex, :club)
  end

end