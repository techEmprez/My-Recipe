require 'rails_helper'

RSpec.describe RecipeFoodsController, type: :controller do
  describe 'GET #index' do
    it 'assigns all recipe foods to @recipe_foods' do
      recipe_food1 = create(:recipe_food)
      recipe_food2 = create(:recipe_food)

      get :index

      expect(assigns(:recipe_foods)).to match_array([recipe_food1, recipe_food2])
    end

    it 'renders the index template' do
      get :index

      expect(response).to render_template(:index)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) { attributes_for(:recipe_food) }

      it 'creates a new recipe food' do
        expect do
          post :create, params: { recipe_food: valid_params }
        end.to change(RecipeFood, :count).by(1)
      end

      it 'redirects to the created recipe food' do
        post :create, params: { recipe_food: valid_params }

        expect(response).to redirect_to(recipe_food_url(RecipeFood.last))
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { attributes_for(:recipe_food, quantity: nil) }

      it 'does not create a new recipe food' do
        expect do
          post :create, params: { recipe_food: invalid_params }
        end.to_not change(RecipeFood, :count)
      end

      it 'renders the new template' do
        post :create, params: { recipe_food: invalid_params }

        expect(response).to render_template(:new)
      end
    end
  end
end
