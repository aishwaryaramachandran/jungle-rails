require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validate the presence of a name, price, quantity and category
    before(:each) do
      @category = Category.new name: 'CategoryName'
      @product = Product.new(name: 'ProdName', price: 300, quantity: 0, category: @category)
    end

    it 'is valid with valid parameters' do
      expect(@product).to be_valid
    end

    it 'is not valid without presence of a name' do
      @product.name = nil

      expect(@product).to_not be_valid
    end

    it 'is not valid without presence of a price' do
      @product.price_cents = nil

      expect(@product).to_not be_valid

    end

    it 'is not valid without presence of a quantity' do
      @product.quantity = nil

      expect(@product).to_not be_valid

    end

    it 'is not valid without presence of a category' do
      @product.category = nil

      expect(@product).to_not be_valid

    end
  end
end
