class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]
  before_action :check_owner, only: %i[ update destroy ]
  # Get /users/1
  def show
    options = {include: [:products]}
    render json: UserSerializer.new(@user, options).serializable_hash.to_json
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: UserSerializer.new(@user).serializable_hash.to_json , status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # Patch/Put /users/1
  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end
  def user_params
    params.require(:user).permit(:email, :password)
  end

  def destroy
    @user.destroy
    head 204
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def check_owner
      head :forbidden unless @user.id == current_user&.id
    end
end
