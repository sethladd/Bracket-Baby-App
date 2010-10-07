class ApplicationController < ActionController::Base
  protect_from_forgery
  include AuthenticationHelper
  
  before_filter :ensure_signed_in
  before_filter :set_timezone

  private
  
  def set_timezone
    Time.zone = current_user.time_zone if current_user
  end
end
