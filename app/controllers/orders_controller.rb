class OrdersController < ApplicationController

def my_achats_index
  @orders = [] # init
  @all_orders = Orders.all
  @all_orders.each do |order|
    if order.user_id == current_user
      @orders << order
      end
    end
end


end
