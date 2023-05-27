require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST /users' do
    it 'creates a new user' do
      expect do
        post users_path, params: { user: { name: 'John Doe' } }
      end.to change(User, :count).by(1)
    end

    it 'redirects to the created user' do
      post users_path, params: { user: { name: 'John Doe' } }
      expect(response).to redirect_to(user_url(User.last))
    end

    it 'renders the new template if creation fails' do
      post users_path, params: { user: { name: '' } }
      expect(response).to render_template(:new)
    end
  end

  describe 'PATCH /users/:id' do
    let!(:user) { create(:user) }

    it 'updates the user' do
      patch user_path(user), params: { user: { name: 'Updated User' } }
      expect(user.reload.name).to eq('Updated User')
    end

    it 'redirects to the updated user' do
      patch user_path(user), params: { user: { name: 'Updated User' } }
      expect(response).to redirect_to(user_url(user))
    end

    it 'renders the edit template if update fails' do
      patch user_path(user), params: { user: { name: '' } }
      expect(response).to render_template(:edit)
    end
  end

  describe 'DELETE /users/:id' do
    let!(:user) { create(:user) }

    it 'destroys the user' do
      expect do
        delete user_path(user)
      end.to change(User, :count).by(-1)
    end

    it 'redirects to the users index' do
      delete user_path(user)
      expect(response).to redirect_to(users_url)
    end
  end
end
