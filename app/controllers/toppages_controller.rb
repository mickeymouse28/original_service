class ToppagesController < ApplicationController
  def index
    if logged_in?
      #@logs = current_user.logs.order(id: :desc).page(params[:page])
      @logs = Log.includes(:user).order(id: :desc).page(params[:page])
    end
  end
end
