class RatingsController < ApplicationController
  before_action :set_rating, only: [:show, :update, :destroy]
  before_action :authenticate_user!

  # GET /ratings
  def index
    if current_user
      @ratings = Rating.all
      render json: @ratings
    else
      render json: { error: 'User Not Authorized' }, status: :unauthorized
    end
  end

  # GET /ratings/1
  def show
    if current_user
      render json: @rating
    else
      render json: { error: 'User Not Authorized' }, status: :unauthorized
    end
  end

  # POST /ratings
  def create
    @rating = Rating.new(rating_params)

    if @rating.save
      render json: @rating, status: :created, location: @rating
    else
      render json: @rating.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ratings/1
  def update
    if current_user.id == @rating.user_id
      if @rating.update(rating_params)
        render json: @rating
      else
        render json: @rating.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'User Not Authorized' }, status: :unauthorized
    end
  end

  # DELETE /ratings/1
  def destroy
    if current_user.id == @rating.user_id
      @rating.destroy
    else
      render json: { error: 'User Not Authorized' }, status: :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating = Rating.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def rating_params
      params.permit(:user_id, :bathroom_id, :rating)
    end
end
