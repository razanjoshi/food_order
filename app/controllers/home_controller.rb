class HomeController < ApplicationController
  def index
  	@products = Product.all
  	@order_item = current_order.order_items.new
  end

  def home_page
  end
end
