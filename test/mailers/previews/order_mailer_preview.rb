class UserMailerPreview < ActionMailer::Preview

  def prepare
    order = Order.first
    OrderMailer.prepare(order)
  end
end
