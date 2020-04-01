class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :favorite

  def favorite
    @favorite ||= Favorite.new(session[:favorites])
  end

  # rescue_from ActiveRecord::RecordNotFound do |exception|
  #   redirect_to "/"
  # end

end
