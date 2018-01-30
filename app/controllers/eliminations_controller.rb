class EliminationsController < ApplicationController
  before_action :set_event, :authorize, :authorize_event, :check_finished_status
  before_action except: [:create_eliminations_lists] { check_status('eliminations') }
  before_action only: [:create_eliminations_lists] { check_status('competitors') }

  def show
      @m1 = @event.list('first_route', 'men')
      @f1 = @event.list('first_route', 'women')
      @m2 = @event.list('second_route', 'men')
      @f2 = @event.list('second_route', 'women')
  end

  def create
    if enough_competitors?
      @event.create_eliminations_lists
      @event.update_attribute(:status, 'eliminations')
      redirect_to eliminations_event_path,
        info: "Eliminations lists have been created."
    else
      redirect_to competitors_event_path,
        danger: "There should be at least two competitors in each category!"
    end
  end

  def destroy
    @event.eliminations_lists.destroy_all
    @event.update_attribute(:status, 'competitors')
    redirect_to competitors_event_path,
      info: 'Eliminations lists have been deleted.'
  end

  private

  def enough_competitors?
    @event.men.size >= 2 && @event.women.size >= 2
  end

end