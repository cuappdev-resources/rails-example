class UsersController < ApplicationController
  def new
  end

  def create
    u = params[:user]
    user = User.create(name: u[:name], email: u[:email], password: u[:password])
    render json: user
  end

  def show
    session_code = cookies[:session_code]
    s = Session.find_by_code(session_code)
    render text: 'Not logged in' and return if s.blank?
    render text: 'Not your profile' and return if s.user_id != params[:id].to_i
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end
end
