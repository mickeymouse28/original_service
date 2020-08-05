class PlansController < ApplicationController
  before_action :require_user_logged_in
  
  def show
    @plan = Plan.find(params[:id])
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = current_user.plans.build(plan_params)
    
    if @plan.save
      flash[:success] = '旅のプランを登録しました'
      redirect_to plans_user_path(@plan.user)
    else
      @plan = current_user.plans.order(id: :desc).page(params[:page])
      flash.now[:danger] = '旅のプランの登録に失敗しました'
      render 'toppages/index'
    end
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def update
    @plan = Plan.find(params[:id])
    
    if @plan.remove_image
      @plan.remove_image!
    end
    
    if @plan.update(plan_params)
      flash[:success] = 'Planは正常に更新されました'
      redirect_to plans_user_path(@plan.user)
    else
      flash.now[:danger] = 'Planは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @plan = Plan.find(params[:id])
    @plan.destroy
    
    flash[:success] = 'Logは正常に削除されました'
    redirect_to plans_user_path(@plan.user)
  end
  
  private
  
  def plan_params
    params.require(:plan).permit(:placename, :date, :content, :image, :remove_image, :image_cache, :rate)
  end
end