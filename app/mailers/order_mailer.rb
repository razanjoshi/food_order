class OrderMailer < ApplicationMailer
  def new_order_mail

    # @order = params[:order]
    mail(to: 'razan.joc@gmail.com', subject: "You got a new order!")
  end
end
