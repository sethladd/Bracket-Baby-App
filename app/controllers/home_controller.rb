class HomeController < ApplicationController
  def index
    @upcoming_tournaments = Tournament.upcoming
    @in_progress_tournaments = Tournament.started_or_should_start
    @finished_tournaments = Tournament.ended
  end  
end