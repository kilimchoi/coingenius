class AdminConstraint
  def matches?(request)
    puts 'request is ', request.session.inspect
    return false unless request.session[:current_user_id]
    user = Sys::User.find request.session[:current_user_id]
    user && user.admin?
  end
end
