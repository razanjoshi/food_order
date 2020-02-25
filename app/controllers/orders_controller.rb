class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def new
    @order = current_order
  end

  def create
    binding.pry
    if user_signed_in?
      #something
    end
    @order = current_order

    if @order.update_attributes(order_params.merge(status: 'open'))
      session[order_id] = nil  #makes cart items 0
      #do something for delivery here, as in change the delivery status to something else
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit()
  end

end
