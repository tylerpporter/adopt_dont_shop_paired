class ShelterReviewsController < ApplicationController

    def edit
      @review = ShelterReview.find(params[:review_id])
    end

    def update
      if ShelterReview.update(params[:review_id], reviews_params).save
        redirect_to "/shelters/#{params[:shelter_id]}"
      else
        flash[:notice] = "Must enter title, rating, and content"
        redirect_to edit_path
      end
    end

    private

    def reviews_params
      params.permit(:title, :rating, :content, :picture, :shelter_id)
    end

    def edit_path
      "/shelters/#{params[:shelter_id]}/#{params[:review_id]}/edit"
    end
end
