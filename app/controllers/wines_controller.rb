class WinesController < ApplicationController
  def show
    @wine = Wine.find(params[:id])
  end
  def index
    @wines = current_user.wines
    @wines = @wines.where(color: params[:color]) if params[:color].present?
    @wines = @wines.where("? = ANY(categories)", params[:category]) if params[:category].present?
  end
end
