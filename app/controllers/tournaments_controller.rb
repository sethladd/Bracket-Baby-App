class TournamentsController < ApplicationController
  def new
    @tournament = Tournament.new
  end
end