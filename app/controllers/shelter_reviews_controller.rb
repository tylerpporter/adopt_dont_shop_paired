class ShelterReviewsController < ApplicationController
  
    def edit
      @review = ShelterReview.find(params[:id])
    end

    def update
      updated = ShelterReview.update(params[:id], reviews_params)
      redirect_to "/shelters/#{updated.shelter_id}"
    end

    private

    def reviews_params
      params.permit(:title, :rating, :content, :picture, :shelter_id)
    end
end
