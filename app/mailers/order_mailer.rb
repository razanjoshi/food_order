class OrderMailer < ApplicationMailer
  def new_order_mail(email, order)
    order_items = order.order_items
    @count = order_items.count
    @product_ids = order.order_items.map(&:product_id).uniq
    mail(to: email, subject: "You got a new order!")
  end

  def order_delivered(email, order)
    order_items = order.order_items
    @count = order_items.count
    @product_ids = order.order_items.map(&:product_id).uniq
    mail(to: email, subject: "Your order has been delivered!")
  end
end
