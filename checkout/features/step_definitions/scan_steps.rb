Given(/^an unknown item$/) do
  product = Product.new('abc123', 10.99)
  @the_item = product
end

Given(/^a known item$/) do
  add_product(Product.new('abc123', 10.99))
end

When(/^the cashier scans the item$/) do
  checkout = Checkout.new(display, product_database)
  checkout.scan(the_item.barcode)
end

Then(/^the item should be added to the total$/) do
  expect(display.total).to eq 10.99
end

Given(/^the cashier should be notified that the item is not recognised$/) do
  expect( display ).to be_showing_not_found
end

module TestDisplay
  def display
    @display ||= Display.new
  end

  class Display
    attr_reader :total

    def initialize
      @total = 0
      @showing_not_found = false
    end

    def add(price)
      @total += price
    end

    def showing_not_found?
      @showing_not_found
    end

    def not_found
      @showing_not_found = true
    end

  end
end
World(TestDisplay)

module UserInterface
  def last_item
    @last_item
  end

  def scan(barcode)
    @last_item = product_database.find_item(barcode)
  end

end
World(UserInterface)

module ProductHelper
  def add_product(product)
    product_database.add_product(product)
    @the_item = product
  end

  def the_item
    @the_item
  end

  def product_database
    @product_list ||= InMemoryProductList.new
  end
end
World(ProductHelper)











