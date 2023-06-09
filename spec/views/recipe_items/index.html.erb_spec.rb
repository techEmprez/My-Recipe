require 'rails_helper'

RSpec.describe 'recipe_items/index', type: :view do
  before(:each) do
    assign(:recipe_items, [
             RecipeItem.create!(
               name: 'Name',
               preparation_time: 2,
               cooking_time: 3,
               description: 'MyText',
               public: false,
               user: nil
             ),
             RecipeItem.create!(
               name: 'Name',
               preparation_time: 2,
               cooking_time: 3,
               description: 'MyText',
               public: false,
               user: nil
             )
           ])
  end

  it 'renders a list of recipe_items' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new('Name'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('MyText'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
