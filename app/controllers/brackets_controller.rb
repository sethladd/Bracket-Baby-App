class BracketsController < ApplicationController
  
  def table
    @tournament = Tournament.find(params[:tournament_id])
    @bracket = @tournament.brackets.where(:id => params[:id]).first
  end

end