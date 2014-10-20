Given(/^a known item$/) do
  add_product(Product.new('abc123', 10.99))
end

When(/^the cashier scans the item$/) do
  scan(the_item.barcode)
end

Then(/^the item should be added to the total$/) do
  expect( display.total ).to eq( last_item.price )
end

Given(/^an unknown item$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^the cashier should be notified that the item is not recognised$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

module TestDisplay
  def display
    @display ||= Display.new
  end

  class Display
    attr_reader :total

    def initialize
      @total = 0
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













