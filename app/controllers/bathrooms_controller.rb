class BathroomsController < ApplicationController
  before_action :set_bathroom, only: [:show, :update, :destroy]

  # GET /bathrooms
  def index
    @bathrooms = Bathroom.all

    render json: @bathrooms
  end

  # GET /bathrooms/1
  def show
    render json: @bathroom
  end

  # POST /bathrooms
  def create
    @bathroom = Bathroom.new(bathroom_params)

    if @bathroom.save
      render json: @bathroom, status: :created, location: @bathroom
    else
      render json: @bathroom.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bathrooms/1
  def update
    if @bathroom.update(bathroom_params)
      render json: @bathroom
    else
      render json: @bathroom.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bathrooms/1
  def destroy
    @bathroom.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bathroom
      @bathroom = Bathroom.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def bathroom_params
      params.require(:bathroom).permit(:name, :description, :lat, :long, :address, :wheelchair, :childfriendly)
    end
end
