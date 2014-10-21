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

class Checkout
  def initialize(display, product_list)
    @product_list = product_list
    @display = display
  end

  def scan(barcode)
    product = @product_list.find_item(barcode)
    if product != nil
      puts "#{product}"
      @display.add(product.price)
    else
      @display.not_found
    end
  end

  def add_item(product)
    @product_list.add_product(product)
  end
end

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
