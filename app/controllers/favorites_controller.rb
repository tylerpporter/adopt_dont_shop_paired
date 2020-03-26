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
    destroy_redirect
  end

  private

  def destroy_redirect
    if request.env["HTTP_REFERER"].split('/').drop(3).unshift('/').join == "/favorites"
      redirect_to "/favorites"
    else
      redirect_to "/pets/#{params[:pet_id]}"
    end
  end

end
