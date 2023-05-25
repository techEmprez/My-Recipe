class RecipeItemsController < ApplicationController
  before_action :set_recipe_item, only: %i[show edit update destroy]

  # GET /recipe_items or /recipe_items.json
  def index
    # eager loading the recipe_items from the database along with their associated recipe_foods records
    @recipe_items = RecipeItem.includes(:user, :foods)
  end

  # GET /recipe_items/1 or /recipe_items/1.json
  def show
    # Eager load the associated records for recipe_foods and user
    @recipe_foods = @recipe_item.recipe_foods.includes(:food)
  end

  # GET /recipe_items/new
  def new
    @recipe_item = RecipeItem.new
  end

  # GET /recipe_items/1/edit
  def edit; end

  # POST /recipe_items or /recipe_items.json
  def create
    @recipe_item = RecipeItem.new(recipe_item_params)

    respond_to do |format|
      if @recipe_item.save
        format.html { redirect_to recipe_item_url(@recipe_item), notice: 'Recipe item was successfully created.' }
        format.json { render :show, status: :created, location: @recipe_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipe_items/1 or /recipe_items/1.json
  def update
    respond_to do |format|
      if @recipe_item.update(recipe_item_params)
        format.html { redirect_to recipe_item_url(@recipe_item), notice: 'Recipe item was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipe_items/1 or /recipe_items/1.json
  def destroy
    @recipe_item.destroy

    respond_to do |format|
      format.html { redirect_to recipe_items_url, notice: 'Recipe item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe_item
    @recipe_item = RecipeItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_item_params
    params.require(:recipe_item).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id)
  end

  def missing_food
    @user = current_user
    @recipe_item = @user.recipe_item.includes(:recipe_foods)
    @general_foods = @user.recipe_foods

    @missing_foods = @general_foods - @recipe_item.flat_map(&:recipe_foods)

    @total_food_items = missing_foods.count
    @total_price = @missing_foods.sum(:price)
  end
end
s