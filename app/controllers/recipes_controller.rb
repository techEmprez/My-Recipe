class RecipesController < ApplicationController
  before_action :authenticate_user!, except: %i[public show]

  def index
    @recipes = Recipe.all.where(user_id: current_user.id).includes(:recipe_foods)
  end

  def show
    @recipe_foods = RecipeFood.all.where(recipe_id: params[:id]).includes(:food)
    @shopping_list =
      @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      redirect_to recipes_url, notice: 'Recipe was successfully created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def public
    @recipes = Recipe.where(public: true).and(Recipe.where.not(user_id: current_user.id))
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    return unless @recipe.user.id == current_user.id

    @recipe.recipe_foods.destroy_all
    @recipe.destroy
    redirect_to recipes_url, notice: 'Recipe was successfully destroyed'
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, :preparation_time, :cooking_time, :public)
  end
end
