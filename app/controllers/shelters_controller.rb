class SheltersController < ApplicationController

  def index
    @highest_rated = Shelter.top_3
    if(params["sort"] == "adoptable")
      @shelters = Shelter.joins(:pets).where("pets.status" == "Adoptable").group("shelters.id").order("count(pets.status) DESC")
    elsif(params["sort"] == "alphabetical")
      @shelters = Shelter.order("name ASC")
    else
      @shelters = Shelter.all
    end
  end

  def create
    if Shelter.create(shelter_params).save
      redirect_to '/shelters'
    else
      error_message
      redirect_to '/shelters/new'
    end
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    if Shelter.update(params[:id], shelter_params).save
      redirect_to "/shelters/#{params[:id]}"
    else
      error_message
      redirect_to "/shelters/#{params[:id]}/edit"
    end
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
    pets.each { |pet_id| favorite.remove_pet(pet_id) }
  end

  def error_message
    messages = ["Please fill out the following fields: "]
    messages << "Name " if params[:name].empty?
    messages << "Address " if params[:address].empty?
    messages << "City " if params[:city].empty?
    messages << "State " if params[:state].empty?
    messages << "Zip " if params[:zip].empty?
    flash[:error] = messages.join
  end

end
