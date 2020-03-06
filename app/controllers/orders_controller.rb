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

    if @order.update_attributes(
      order_params.merge(
        status: 'open',
        card_token: params[:stripeToken]
        )
      )

      process_payment(params[:stripeEmail], params[:stripeToken])

      session[:order_id] = nil  #makes cart items 0
      #do something for delivery here, as in change the delivery status to something else

      redirect_to root_path
      flash[:notice] = "Food order succesfully ordered."
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:status, :user_id, :total, :stripeEmail, :stripeToken, :address, :phone)
  end

  def process_payment(email, card_token)
    customer = Stripe::Customer.create email: email,
                                       card: card_token

    Stripe::Charge.create customer: customer.id,
                          amount: (@order.subtotal * 100).to_i,
                          description: @order.order_items.count.to_s,
                          currency: 'usd'

  end

end
