class ShelterReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    shelter_id = params[:id]
    picture = params[:picture]
    picture = nil if params[:picture].empty?
    review = ShelterReview.new({
      title: params[:title],
      rating: params[:rating],
      content: params[:content],
      picture: picture,
      shelter_id: shelter_id,
    })
    review.save
    redirect_to "/shelters/#{shelter_id}"
  end

  # private
  #
  # def shelter_review_params
  #   params.permit(:title, :rating, :content, :picture)
  # end
end
