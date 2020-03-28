class SheltersController < ApplicationController

  def index
    if(params["sort"] == "adoptable")
      @shelters = Shelter.joins(:pets).where("pets.status" == "Adoptable").group("shelters.id").order("count(pets.status) DESC")
    elsif(params["sort"] == "alphabetical")
      @shelters = Shelter.all.order("name ASC")
    else
      @shelters = Shelter.all
    end
  end

  def create
    shelter = Shelter.create(shelter_params)
    shelter.save
    redirect_to '/shelters'
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.update(params[:id], shelter_params)
    shelter.save
    redirect_to "/shelters/#{shelter.id}"
  end

  def destroy
    shelter = Shelter.find(params[:id])
    remove_favorited_pets(shelter)
    shelter.destroy
    redirect_to '/shelters'
  end

  private

  def shelter_params
    params.permit(:name,
                  :address,
                  :city,
                  :state,
                  :zip)
  end

  def remove_favorited_pets(shelter)
    pets = shelter.pets.map(&:id)
    pets.each { |pet_id| favorite.remove_pet(pet_id.to_s) }
  end

end