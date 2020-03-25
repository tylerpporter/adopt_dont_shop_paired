class ShelterReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:id])
  end

  def edit
    @review = ShelterReview.find(params[:review_id])
  end

  def create
    shelter = Shelter.find(params[:id])
    if shelter.shelter_reviews.create(reviews_params).save
      redirect_to path[:index]
    else
      flash_message
      redirect_to path[:new_review]
    end
  end

  def update
    if ShelterReview.update(params[:review_id], reviews_params).save
      redirect_to path[:shelter_index]
    else
      flash_message
      redirect_to path[:edit_review]
    end
  end

  def delete
    ShelterReview.destroy(params[:review_id])
    redirect_to path[:shelter_index]
  end

  private

  def reviews_params
    params.permit(:title, :rating, :content, :picture, :shelter_id)
  end

  def path
    {
      edit_review: "/shelters/#{params[:shelter_id]}/#{params[:review_id]}/edit",
      shelter_index: "/shelters/#{params[:shelter_id]}",
      index: "/shelters/#{params[:id]}",
      new_review: "/shelter_reviews/#{params[:id]}/new"
    }
  end

  def flash_message
    messages = ["Please fill out the following fields: "]
    messages << "Title " if params[:title].empty?
    messages << "Rating " if params[:rating].empty?
    messages << "Content " if params[:content].empty?
    flash[:error] = messages.join
  end

end
