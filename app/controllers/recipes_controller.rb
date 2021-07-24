class RecipesController < ApplicationController

    def index
    recipes = Recipe.all
    if session[:user_id]    
      render json: recipes
    else 
     render json: {errors: ["Not logged in"] }, status: 401
    end
    end


    def create
        user = User.find(session[:user_id])
       recipe = user.recipes.create(recipe_params)
       if recipe.valid?
       render json: recipe, status: 201
       else 
        render json: {errors: recipe.errors.full_messages}, status: 422
       end
    rescue ActiveRecord::RecordNotFound => e
  
        render  json: {errors: [e.message]}, status: 401

    end

  def recipe_params
      params.permit(:title, :instructions, :minutes_to_complete, :user_id)
  end 

end
