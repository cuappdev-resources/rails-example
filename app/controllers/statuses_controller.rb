class StatusesController < ApplicationController
  def index
    @statuses = Status.all
  end

  def new
  end

  def create
    session_code = cookies[:session_code]
    s = Session.find_by_code(session_code)
    render text: 'Not allowed to post' and return if s.blank?
    user_id = s.user_id
    status = Status.new(content: params[:status][:content])
    status.user_id = user_id
    status.save
    redirect_to '/statuses'
  end
end
