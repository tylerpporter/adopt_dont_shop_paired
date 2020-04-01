class PetsController < ApplicationController

  def index
    if(params["adoptable"] == "true")
      @pets = Pet.where(:status => "Adoptable")
    elsif(params["adoptable"] == "false")
      @pets = Pet.where(:status => "Pending")
    else
      @pets = Pet.all
    end
  end

  def show
    @pet = Pet.find(params[:id])
    @status_link = {}
    if(@pet.status == "Adoptable")
      @status_link[:name] = "Change to Adoption Pending"
      @status_link[:path] = "/pets/#{@pet.id}/pending"
    else
      @status_link[:name] = "Change to Adoptable"
      @status_link[:path] = "/pets/#{@pet.id}/adoptable"
    end
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    if Pet.update(params[:id], pet_params).save
      redirect_to "/pets/#{params[:id]}"
    else
      error_message
      redirect_to "/pets/#{params[:id]}/edit"
    end
  end

  def update_adopt_status
    Pet.update(params[:id], status: "Pending").save
    redirect_to "/pets/#{params[:id]}"
  end

  def update_pending_status
    Pet.update(params[:id], status: "Adoptable").save
    redirect_to "/pets/#{params[:id]}"
  end

  def destroy
    pet = Pet.find(params[:id])
    if pet.notes.nil?
      favorite.remove_pet(pet.id) if favorite.contents.include? pet.id.to_s
      pet.destroy
    else
      flash[:error] = "Pet cannot be deleted"
    end
    redirect_to '/pets'
  end

  private

  def pet_params
    params.permit(:image,
                  :name,
                  :approx_age,
                  :description,
                  :sex)
  end

  def error_message
    messages = ["Please fill out the following fields: "]
    messages << "Image " if params[:image].empty?
    messages << "Name " if params[:name].empty?
    messages << "Age " if params[:approx_age].empty?
    messages << "Description " if params[:description].empty?
    messages << "Sex " if params[:sex].empty?
    flash[:error] = messages.join
  end

end