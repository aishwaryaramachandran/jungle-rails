class CartsController < ApplicationController

  def show
  end

  def add_item
    product_id = params[:product_id].to_s
    product = Product.find(product_id)

    if (product.quantity == 0)
      redirect_to :back, notice: "#{product.name} is currently out of stock"
    elsif (product. quantity <= 1)
      redirect_to :back, notice: "The #{product.name} is in limited stock"
    else
    item = cart[product_id] || { "quantity" => 0 }
    item["quantity"] += 1
    cart[product_id] = item
    update_cart cart

    redirect_to :back
    end
  end

  def remove_item
    product_id = params[:product_id].to_s

    item = cart[product_id] || { "quantity" => 1 }
    item["quantity"] -= 1
    cart[product_id] = item
    cart.delete(product_id) if item["quantity"] < 1
    update_cart cart

    redirect_to :back
  end

end
