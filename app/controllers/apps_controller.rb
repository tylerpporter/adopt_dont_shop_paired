class AppsController < ApplicationController

  def new
    @fav_pets = Pet.find(session[:favorites])
  end

  def index
    @pet = Pet.find(params[:pet_id])
  end

  def show
    @app = App.find(params[:id])
  end

  def create
    app = App.create(app_params)
    if app.id
      app_pets = Pet.find(params[:adopt_pet])
      app.pets.push(app_pets)
      redirect_flash(:success)
      app_pets.each {|pet| favorite.contents.delete(pet.id.to_s)}
    else
      redirect_flash(:error)
    end
  end

  def update
    app_id = request.env["HTTP_REFERER"].split("/")[-1]
    app = App.find(app_id)
    Pet.update(params[:pet_id], status: "Pending", adopted: "On hold for #{app.name}")
    redirect_to "/pets/#{params[:pet_id]}"
  end

  def delete
    app_id = request.env["HTTP_REFERER"].split("/")[-1]
    Pet.update(params[:pet_id], status: "Adoptable", adopted: nil)
    redirect_to "/apps/#{app_id}"
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
