class WinesController < ApplicationController
  def show
    @wine = Wine.find(params[:id])
  end
  def index
    @wines = current_user.wines
  end
end
