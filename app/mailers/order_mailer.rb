class OrderMailer < ApplicationMailer

  def prepare(order)
    @order = order

    mail to: @order.article.user.email, subject: "Youpi une nouvelle commande [n° #{@order.id}] "

  end
end
