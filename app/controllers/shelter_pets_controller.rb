class ShelterPetsController < ApplicationController

  def index
    if(params["adoptable"] == "true")
      @pets = Pet.where(:shelter_id => params[:id], :status => "Adoptable")
    elsif(params["adoptable"] == "false")
      @pets = Pet.where(:shelter_id => params[:id], :status => "Pending")
    else
      @pets = Pet.where(:shelter_id => params[:id])
    end
    @pet_num = @pets.size
    @shelter = Shelter.find(params[:id])
  end

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    shelter_id = params[:id]
    # save_pet_image(params[:image])
    pet = Pet.new({
      image: params[:image],
      name: params[:name],
      approx_age: params[:approx_age],
      description: params[:description],
      sex: params[:sex],
      status: "Adoptable",
      shelter_id: shelter_id,
    })
    pet.save
    redirect_to "/shelters/#{shelter_id}/pets"
  end

  # private
  #
  # def save_pet_image(image)
  #   File.open(Rails.root.join(Rails.root + '/assets/images/pets', image.original_filename), 'wb') do |file|
  #     file.write(image.read)
  #   end
  # end

end