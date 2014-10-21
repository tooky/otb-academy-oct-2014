require 'sinatra'

get '/scan' do
  barcode =  params[:q]
  barcode.to_s
  erb :layout
end

template :layout do
  "<div id=\"total\"> 10.99 </div>" + 
  "<div id=\"notfound\"> Item not found </div>"
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

