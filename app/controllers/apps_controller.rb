class AppsController < ApplicationController

  def new
    @fav_pets = Pet.find(session[:favorites])
  end

  def create
    app = App.create(app_params)
    app_pets = Pet.find(params[:adopt_pet])
    if app.id
      app.pets.push(app_pets)
      redirect_flash(:success)
      app_pets.each {|pet| favorite.contents.delete(pet.id.to_s)}
    else
      redirect_flash(:error)
    end
  end

  private

  def app_params
    params.permit(:name,
                  :address,
                  :city,
                  :state,
                  :zip,
                  :phone_number,
                  :description,
                  :pet_ids)
  end

  def redirect_flash(type)
    if type == :success
      redirect_to "/favorites"
      flash[:success] = "Application submitted successfully!"
    elsif type == :error
      redirect_to "/apps/new"
      flash[:error] = "Application not submitted. Please complete the required fields."
    end
  end

end
