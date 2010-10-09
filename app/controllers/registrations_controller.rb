class RegistrationsController < ApplicationController
  
  def create
    @tournament = Tournament.find(params[:tournament_id])
    @registration = @tournament.registrations.build(:user => current_user)
    unless @registration.save
      flash[:error] = "Uh oh: #{@registration.errors.full_messages.join("<br>")}"
    end
    redirect_to @tournament
  end
  
  def destroy
    @registration = Registration.find(params[:id])
    @registration.destroy
    redirect_to tournament_path(params[:tournament_id])
  end
  
end