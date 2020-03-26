class FavoritesController < ApplicationController

  def index
    @pets = Pet.find(session[:favorites])
  end

  def update
    pet = Pet.find(params[:pet_id])

    favorite.add_pet(pet.id)
    session[:favorites] = favorite.contents

    flash[:notice] = "#{pet.name} has been added to favorites"
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet = Pet.find(params[:pet_id])

    favorite.remove_pet(pet.id)
    session[:favorites] = favorite.contents

    flash[:notice] = "#{pet.name} has been removed from favorites"

    @pets = Pet.find(session[:favorites])
    render :index
  end

end
