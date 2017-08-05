class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /ratings
  def index
    @Users = Rating.all
    render json: @Users
  end

  # GET /Users/1
  def show
    render json: @user
  end

  # POST /Users
  def create
    @user = user.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /Users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /Users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = user.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:user_id, :bathroom_id, :rating)
    end
end
