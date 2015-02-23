class SessionsController < ApplicationController
  def new
  end

  def create
    user = params[:user]
    email = user[:email]
    password = user[:password]

    u = User.find_by_email(email)
    render text: 'No user with email' and return if u.blank?
    valid_password = u.authenticate(password)
    if valid_password
      s = Session.new(user_id: u.id)
      s.save_with_session_code
      cookies.permanent[:session_code] = s.code
      redirect_to u
    else
      render text: 'Invalid password' and return
    end
  end
end
