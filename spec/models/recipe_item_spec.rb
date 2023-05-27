require 'rails_helper'

RSpec.describe RecipeItemsController, type: :controller do
  describe '#create' do
    it 'creates a new recipe item' do
      expect do
        post :create, params: { recipe_item: { name: 'New Recipe', preparation_time: 10 } }
      end.to change(RecipeItem, :count).by(1)
    end

    it 'redirects to the created recipe item' do
      post :create, params: { recipe_item: { name: 'New Recipe', preparation_time: 10 } }
      expect(response).to redirect_to(recipe_item_url(RecipeItem.last))
    end

    it 'renders the new template if creation fails' do
      post :create, params: { recipe_item: { name: '' } }
      expect(response).to render_template(:new)
    end
  end

  describe '#update' do
    let!(:recipe_item) { create(:recipe_item) }

    it 'updates the recipe item' do
      patch :update, params: { id: recipe_item.id, recipe_item: { name: 'Updated Recipe' } }
      expect(recipe_item.reload.name).to eq('Updated Recipe')
    end

    it 'redirects to the updated recipe item' do
      patch :update, params: { id: recipe_item.id, recipe_item: { name: 'Updated Recipe' } }
      expect(response).to redirect_to(recipe_item_url(recipe_item))
    end

    it 'renders the edit template if update fails' do
      patch :update, params: { id: recipe_item.id, recipe_item: { name: '' } }
      expect(response).to render_template(:edit)
    end
  end

  describe '#destroy' do
    let!(:recipe_item) { create(:recipe_item) }

    it 'destroys the recipe item' do
      expect do
        delete :destroy, params: { id: recipe_item.id }
      end.to change(RecipeItem, :count).by(-1)
    end

    it 'redirects to the recipe items index' do
      delete :destroy, params: { id: recipe_item.id }
      expect(response).to redirect_to(recipe_items_url)
    end
  end
end
