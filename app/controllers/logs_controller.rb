class LogsController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_log, only: [:show, :edit, :update, :destroy]
  
  def show
  end
  
  def new
    @log = Log.new
  end

  def create
    @log = current_user.logs.build(log_params)
    
    if @log.save
      flash[:success] = '旅のログを登録しました'
      redirect_to logs_user_path(@log.user)
    else
      @logs = current_user.logs.order(id: :desc).page(params[:page])
      flash.now[:danger] = '旅のログの登録に失敗しました'
      render :new
    end
  end

  def edit
  end

  def update
    if @log.remove_image
      @log.remove_image!
    end
    
    if @log.update(log_params)
      flash[:success] = 'Logは正常に更新されました'
      redirect_to logs_user_path(@log.user)
    else
      flash.now[:danger] = 'Logは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @log.destroy
    
    flash[:success] = 'Logは正常に削除されました'
    redirect_to logs_user_path(@log.user)
  end
  
  private
  
  def set_log
    @log = Log.find(params[:id])
  end
  
  def log_params
    params.require(:log).permit(:placename, :date, :content, :image, :remove_image, :image_cache, :rate)
  end
end
