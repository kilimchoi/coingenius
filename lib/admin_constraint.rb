class AdminConstraint
  def matches?(request)
    puts 'session:', request.session.inspect
  end
end
