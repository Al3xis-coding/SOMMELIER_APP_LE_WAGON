class WinesController < ApplicationController
  def show
    @wine = Wine.find(params[:id])
  end
  def index
    @wines = Wine.all
  end
end
