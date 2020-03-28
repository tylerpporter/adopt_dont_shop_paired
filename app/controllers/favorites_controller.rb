class FavoritesController < ApplicationController

  def index
<<<<<<< HEAD
    if session[:favorites].present?
      @pets = Pet.find(session[:favorites])
    end
=======
    @all_pets = Pet.all 
    @pets = Pet.find(session[:favorites])
>>>>>>> bcd2eeb984353b66ccf03d858f3ce77b0f68d584
  end

  def update
    pet = Pet.find(params[:pet_id])
    favorite.add_pet(pet.id)
    session[:favorites] = favorite.contents
    flash[:notice] = "#{pet.name} has been added to favorites"
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    if params[:pet_id].nil?
      favorite.remove_all_pets
      flash[:notice] = "Removed all pets from favorites"
    else
      pet = Pet.find(params[:pet_id])
      favorite.remove_pet(pet.id)
      flash[:notice] = "#{pet.name} has been removed from favorites"
    end
    redirect_to(request.env["HTTP_REFERER"])
  end

end
