require 'checkout'

RSpec.describe InMemoryProductList do
  it "can find a product by it's barcode" do
    product_list = InMemoryProductList.new

    product = Product.new('abc1234', 10.99)
    product_list.add_product product

    expect(product_list.find_item('abc1234')).to eq(product)
  end
end
