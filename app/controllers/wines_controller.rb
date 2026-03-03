class WinesController < ApplicationController
  def show
    @wine = Wine.find(params[:id])
  def index
    @wines = Wine.all
  end
end
