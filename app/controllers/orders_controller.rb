class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def new
    @order = current_order
  end

  def create
    @order = current_order
    unless user_signed_in? && current_user.guest?
      order_params.merge(user_id: current_user.id)
    end

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
    params.require(:order).permit(:status, :user_id, :total)
  end

end
