class TournamentsController < ApplicationController
  before_filter :ensure_signed_in
  
  def new
    @tournament = Tournament.new
  end
  
  def create
    @tournament = Tournament.new(params[:tournament])
    if @tournament.save
      redirect_to @tournament
    else
      render :action => :new
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