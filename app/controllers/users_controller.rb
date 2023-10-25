class UsersController < ApplicationController
    skip_before_action :authenticate_request, only: [:create]
    # before_action :find_user, only: [:show, :destroy]
  

    def index
      @users = User.all
      render json: @users, status: :ok
    end
  

    def show
      render json: @user, status: :ok
    end
  

    def create
      @user = User.new(user_params)
      if @user.save
        render json: @user, status: :created
      else
        render json: { errors: @user.errors.full_messages },
               status: :unprocessable_entity
      end
    end
  

    def update
        @user = User.find(params[:id])
       if @user.update(user_params)
        render json: @user, status: :created
       else
        render json: { errors: @user.errors.full_messages },
               status: :unprocessable_entity
       end
    end
  

    def destroy
      @user.destroy
    end
  
    private
  
    def find_user
      @user = User.find(params[:id])
    end
  
    def user_params
      params.permit( :name, :username, :email, :password, :password_confirmation)
    end
end
