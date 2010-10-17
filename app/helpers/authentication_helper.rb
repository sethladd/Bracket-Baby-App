module AuthenticationHelper
  def signed_in?
    !session[:user_id].nil?
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id])
  rescue
    session[:user_id] = nil
  end
  
  def ensure_signed_in
    if ENV['OFFLINE']
      session[:user_id] = 1
      return
    end
    
    unless signed_in? && User.find_by_id(session[:user_id])
      session[:user_id] = nil
      session[:redirect_to] = request.fullpath
      redirect_to(new_session_path)
    end
  end
  
  def ensure_admin
    head 401 and return unless current_user.admin?
  end
end