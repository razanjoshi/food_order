class CartsController < ApplicationController
	def show
		@order_items = current_order.order_items
	end

	def order_now
		binding.pry
		current_order.order_now
	end
end
