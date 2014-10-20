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
