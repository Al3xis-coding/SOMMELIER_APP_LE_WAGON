class WinesController < ApplicationController
  def show
    @wine = Wine.find(params[:id])
  end
end
