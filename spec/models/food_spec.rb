require 'rails_helper'

RSpec.feature 'Foods', type: :feature do
  before(:each) do
    @food = Food.create(name: 'Apple', measurement_unit: 'kg', quantity: 5, price: 2.5)
  end

  scenario 'User views the list of foods' do
    visit foods_path

    expect(page).to have_content('Apple')
    expect(page).to have_content('kg')
    expect(page).to have_content('5')
    expect(page).to have_content('$2.5')
  end

  scenario 'User views a specific food' do
    visit food_path(@food)

    expect(page).to have_content('Apple')
    expect(page).to have_content('kg')
    expect(page).to have_content('5')
    expect(page).to have_content('$2.5')
  end

  scenario 'User deletes a food' do
    visit foods_path

    expect { click_button 'Delete' }.to change(Food, :count).by(-1)
    expect(page).not_to have_content('Apple')
  end
end
