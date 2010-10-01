class TournamentsController < ApplicationController
  
  def new
    @tournament = Tournament.new
  end
  
  def create
    old_time_zone = Time.zone
    begin
      Time.zone = params[:tournament][:time_zone]
      @tournament = Tournament.new(params[:tournament])
      if @tournament.save
        redirect_to @tournament
      else
        render :action => :new
      end
    ensure
      Time.zone = old_time_zone
    end
  end
  
  def show
    @tournament = Tournament.find(params[:id])
  end
  
  def upcoming
    @tournaments = Tournament.upcoming
  end
  
  def in_progress
    @tournaments = Tournament.in_progress
  end
  
  def finished
    @tournaments = Tournament.finished
  end
  
end