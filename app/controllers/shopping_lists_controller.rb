class ShoppingListsController < ApplicationController
  before_action :set_shopping_list, only: %i[show edit update destroy]

  # GET /shopping_lists or /shopping_lists.json
  def index
    @shopping_lists = ShoppingList.all
    @par = request.query_parameters
  end

  # GET /shopping_lists/1 or /shopping_lists/1.json
  def show; end

  # GET /shopping_lists/new
  def new
    @all_inventories = Inventory.all
    @shopping_list = ShoppingList.new
  end

  def shop; end

  # POST /shopping_lists or /shopping_lists.json
  def create
    @shopping_list = ShoppingList.new(shopping_list_params)
    recipe_id = params[:recipe_id]
    @shopping_list.recipe_id = recipe_id

    if @shopping_list.save
      redirect_to shopping_url
    else
      redirect_to recipe_url(params[:recipe_id]), alert: 'Form not saved'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_shopping_list
    @shopping_list = ShoppingList.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def shopping_list_params
    params.require(:shopping_list).permit(:inventory_id)
  end
end
