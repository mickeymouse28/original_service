class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    log = Log.find(params[:log_id])
    current_user.favorite(log)
    flash[:success] = 'Favoriteに保存しました'
    redirect_to likes_user_path(current_user.id)
  end

  def destroy
    log = Log.find(params[:log_id])
    current_user.unfavorite(log)
    flash[:success] = 'Favoriteから削除しました'
    redirect_to likes_user_path(current_user.id)
  end
end
