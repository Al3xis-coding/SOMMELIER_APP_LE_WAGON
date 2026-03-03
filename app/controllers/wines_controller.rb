class WinesController < ApplicationController
<<<<<<< HEAD
  def show
    @wine = Wine.find(params[:id])
=======
  def index
    @wines = Wine.all
>>>>>>> fec0c29dc16eb7fea9dd44dbe7a52b10b439fc3d
  end
end
