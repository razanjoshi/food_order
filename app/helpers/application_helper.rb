module ApplicationHelper

	def current_order
		if !session[:order_id].nil?
			Order.find(session[:order_id])
		else
			Order.new
		end
	end

	def current_cart
		current_order.order_items
	end
end
