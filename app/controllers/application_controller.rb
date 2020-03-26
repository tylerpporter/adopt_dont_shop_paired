class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
  end

  helper_method :favorite

  def favorite
    @favorite ||= Favorite.new(session[:favorites])
  end

end
