class InventoryFoodsController < ApplicationController
  before_action :set_inventory_food, only: %i[show destroy]

  def index
    @inventory_foods = InventoryFood.all
  end

  def show; end

  def new
    @all_foods = Food.all
    @inventory_food = InventoryFood.new
  end

  def edit; end

  # POST /inventory_foods or /inventory_foods.json
  def create
    @inventory_food = InventoryFood.new(inventory_food_params)
    inventory_id = params[:inventory_id]
    @inventory_food.inventory_id = inventory_id

    respond_to do |format|
      if @inventory_food.save
        format.html { redirect_to inventory_url(inventory_id), notice: 'Inventory food was successfully created.' }
      else
        format.html do
          redirect_to new_inventory_inventory_food_url(inventory_id), status: :unprocessable_entity,
                                                                      alert: 'Incomplete form submitted'
        end
      end
    end
  end

  # DELETE /inventory_foods/1 or /inventory_foods/1.json
  def destroy
    @inventory_food.destroy

    respond_to do |format|
      format.html { redirect_to inventory_url, notice: 'Inventory food was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_inventory_food
    @inventory_food = InventoryFood.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def inventory_food_params
    params.require(:inventory_food).permit(:quantity, :food_id)
  end
end
