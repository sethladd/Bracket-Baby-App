class ParticipantsController < ApplicationController
  
  def create
    @tournament = Tournament.find(params[:tournament_id])
    @participant = @tournament.participants.build(:user => current_user)
    unless @participant.save
      flash[:error] = "Uh oh: #{@participant.errors.full_messages.join("<br>")}"
    end
    redirect_to @tournament
  end
  
  def destroy
    @participant = Participant.find(params[:id])
    @participant.destroy
    redirect_to tournament_path(params[:tournament_id])
  end
  
end