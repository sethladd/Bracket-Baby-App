class UsersController < ApplicationController
  
  before_filter :ensure_current_user
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to edit_user_path(@user)
    else
      render :action => :edit
    end
  end
  
  private
  
  def ensure_current_user
    head(401) unless current_user.id.to_s == params[:id]
  end
  
end