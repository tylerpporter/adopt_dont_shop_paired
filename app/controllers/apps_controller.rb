class AppsController < ApplicationController

  def new
    @fav_pets = Pet.find(session[:favorites])
  end

  def index
    @pet = Pet.find(params[:pet_id])
  end

  def show
    app = App.find(params[:id])
    @app = AppDecorator.new(app)
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
    if params[:adopt_pet].present?
      app = App.find(params[:id])
      Pet.where(:id => params[:adopt_pet]).update(status: "Pending", notes: "On hold for #{app.name}")
    else
      app = App.find(params[:app_id])
      Pet.update(params[:pet_id], status: "Pending", notes: "On hold for #{app.name}")
    end
    redirect_to "/pets/#{params[:pet_id]}"
  end

  def delete
    Pet.update(params[:pet_id], status: "Adoptable", notes: nil)
    redirect_to "/apps/#{params[:app_id]}"
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
