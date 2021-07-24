class SessionsController < ApplicationController
    

    def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
     session[:user_id] = user.id
    
     render json: user 
    else
     
      render json: {errors: ["Get bent"]}, status: 401
    end
    end

    def destroy 
     if session[:user_id]
      session.delete(:user_id) 
      head :no_content
     else 
       render json: {errors: ["Here is your array"] }, status: 401
     end      

    end

private

    def login_params
     params.permit(:username, :password)
    end



end
