require 'sinatra'

get '/scan' do
  erb :index
end

post "/scan" do
  barcode =  params[:barcode].to_s

  if product = settings.product_list.find_item(barcode)
    erb :success, locals: { price: product.price }
  else
    erb :not_found
  end
end

template :success do
  "<div id='total'><%= price %></div>"
end

template :not_found do
  "<div id='notfound'>Product Not Found</div>"
end

class Product < Struct.new(:barcode, :price)
end

class InMemoryProductList
  def add_product(product)
    products[product.barcode] = product
  end

  def find_item(barcode)
    products[barcode]
  end

  private
  def products
    @products ||= {}
  end
end

