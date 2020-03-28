class SheltersController < ApplicationController

  def index
    if(params["sort"] == "adoptable")
      @shelters = Shelter.joins(:pets).where("pets.status" == "Adoptable").group("shelters.id").order("count(pets.status) DESC")
      # Shelter.left_joins(:pets).group(:id).order Pet.where(:status => "Adoptable").count
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
    Shelter.destroy(params[:id])
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

end