class ApplicationController < ActionController::Base
  protect_from_forgery
  include AuthenticationHelper
  
  before_filter :ensure_signed_in
end
