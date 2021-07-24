class UsersController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_user
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

    def create
        user = User.create(user_params)
        if user.valid?
          session[:user_id] = User.last.id
          render json: user, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def show
    user = User.find(session[:user_id])
    render json: user, status: 201
    end


    private 

    def user_params
     params.permit(:username, :password, :password_confirmation, :image_url, :bio)
    end

    def handle_invalid_user error
     render json: {errors: error.message }, status: 422
    end

    def render_not_found error
        render json: {errors: error.message}, status: 401
    end
end
