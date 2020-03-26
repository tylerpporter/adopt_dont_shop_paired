class FavoritesController < ApplicationController

  def update
    pet = Pet.find(params[:pet_id])

    favorite.add_pet(pet.id)
    session[:favorites] = favorite.contents

    flash[:notice] = "#{pet.name} has been added to favorites"
    redirect_to "/pets/#{pet.id}"
  end

end
