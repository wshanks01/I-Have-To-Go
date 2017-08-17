class BathroomsController < ApplicationController
  before_action :set_bathroom, only: [:show, :update, :destroy]
  before_action :authenticate_user!

  # GET /bathrooms
  def index
    if current_user
      @bathrooms = Bathroom.all
      render json: @bathrooms
    else
      render json: { error: 'User Not Authorized' }, status: :unauthorized
    end
  end

  # GET /bathrooms/1
  def show
    if current_user
      render json: @bathroom
    else
      render json: { error: 'User Not Authorized' }, status: :unauthorized
    end
  end

  # POST /bathrooms
  def create
    if current_user
      @bathroom = Bathroom.new(bathroom_params)

      if @bathroom.save
        render json: @bathroom, status: :created, location: @bathroom
      else
        render json: @bathroom.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'User Not Authorized' }, status: :unauthorized
    end
  end

  # PATCH/PUT /bathrooms/1
  def update
    if current_user.id == @bathroom.user_id
      if @bathroom.update(bathroom_params)
        render json: @bathroom
      else
        render json: @bathroom.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'User Not Authorized' }, status: :unauthorized
    end
  end

  # DELETE /bathrooms/1
  def destroy
    if current_user.id == @bathroom.user_id
      @bathroom.destroy
    else
      render json: { error: 'User Not Authorized' }, status: :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bathroom
      @bathroom = Bathroom.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def bathroom_params
      params.permit(:name, :description, :lat, :long, :address, :wheelchair, :childfriendly)
    end
end
