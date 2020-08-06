class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :logs, :plans, :likes]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました'
      redirect_to logs_user_path(@user)
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました'
      render :new
    end
  end
  
  def logs
    @user = User.find(params[:id])
    @logs = @user.logs.order(id: :desc).page(params[:page])
    counts(@user)
  end
  
  def plans
    @user = User.find(params[:id])
    @plans = @user.plans.order(id: :desc).page(params[:page])
    counts(@user)
  end
  
  def likes
    @user = User.find(params[:id])
    @likes = @user.likes.order(id: :desc).page(params[:page])
    counts(@user)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
