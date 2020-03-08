class OrdersController < ApplicationController
  def index
    check_isadmin?
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
        stripe_email: params[:stripeEmail],
        card_token: params[:stripeToken],
        user_id: current_user.guest? ? nil : current_user.id
        )
      )

      process_payment(params[:stripeEmail], params[:stripeToken])
      OrderMailer.new_order_mail(params[:stripeEmail], @order).deliver_now
      session[:order_id] = nil  #makes cart items 0

      redirect_to root_path
      flash[:notice] = "Food order succesfully ordered."
    else
      render :new
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(order_params)
      if order_params[:status] == 'delivered'
        OrderMailer.order_delivered(@order.stripe_email, @order).deliver_now
      end

      redirect_to orders_path
      flash[:notice] = 'Order successfully updated.'
    else
      render 'edit'
      flash[:alert] = 'Could not update the order.'
    end
  end

  private

  def check_isadmin?
    return unless !current_user.is_admin
    redirect_to root_path
    flash[:alert] = "You are not authorized to access this page."
  end

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
