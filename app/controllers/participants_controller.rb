class ParticipantsController < ApplicationController
  
  def create
    @tournament = Tournament.find(params[:tournament_id])
    @participant = @tournament.participants.create(:user => current_user)
    unless @participant.save
      flash[:error] = "Problem adding you to this tournament."
    end
    redirect_to @tournament
  end
  
  def destroy
    @participant = Participant.find(params[:id])
    @participant.destroy
    redirect_to tournament_path(params[:tournament_id])
  end
  
end