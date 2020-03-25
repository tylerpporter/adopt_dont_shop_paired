class ShelterReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    shelter_id = params[:id]
    if params[:title].empty? || params[:rating].empty? || params[:content].empty?
      messages = []
      messages << "Please fill out the following fields:"
      messages << "Title" if params[:title].empty?
      messages << "Rating" if params[:rating].empty?
      messages << "Content" if params[:content].empty?
      flash[:error] = messages
      redirect_to "/shelter_reviews/#{shelter_id}/new"
    else
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
  end

  def delete
    ShelterReview.destroy(params[:review_id])
    redirect_to "/shelters/#{params[:shelter_id]}"
  end

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
