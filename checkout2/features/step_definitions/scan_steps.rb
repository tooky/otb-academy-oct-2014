Before do
  @product_list = InMemoryProductList.new
  Sinatra::Application.set :product_list, @product_list
end

Given(/^a known item$/) do
  
  @product = Product.new("abc", 9.99)
  @product_list.add_product(@product)
end

When(/^the cashier scans the item$/) do
  visit "/scan"

  fill_in "barcode", with: "abc"
  click_button "scan"
end

Then(/^the item should be added to the total$/) do
  within("#total") do
    expect(page).to have_content @product.price
  end
end

Given(/^an unknown item$/) do
  @product = Product.new("abc", 9.99)
end

Then(/^the cashier should be notified that the item is not recognised$/) do
  expect(page).to have_content "Product Not Found"
end