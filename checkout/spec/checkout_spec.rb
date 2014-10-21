require 'checkout'

RSpec.describe Checkout do
  it "Should scan an item and display price" do
    product_list = InMemoryProductList.new
    product = Product.new('abc123', 9.99)
    display = double("Display")
    checkout = Checkout.new(display, product_list)
    checkout.add_item(product)
    expect(display).to receive(:add).with(9.99)
    checkout.scan('abc123')
  end

  it "should display an item not found message when not found" do
    product_list = InMemoryProductList.new
    product = Product.new('abc123', 9.99)
    display = double("Display")
    checkout = Checkout.new(display, product_list)
    expect(display).to receive(:not_found)
    checkout.scan('abc123')
  end
end