class WinesController < ApplicationController
<<<<<<< HEAD
<<<<<<< HEAD
  def show
    @wine = Wine.find(params[:id])
=======
  def index
    @wines = Wine.all
>>>>>>> fec0c29dc16eb7fea9dd44dbe7a52b10b439fc3d
=======
  def show
    @wine = Wine.find(params[:id])
  def index
    @wines = Wine.all
>>>>>>> 532923e2581e7c5332e383031614f456d49aa873
  end
end
