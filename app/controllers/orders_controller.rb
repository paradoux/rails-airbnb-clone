class OrdersController < ApplicationController

def myachatsindex
  # user_id de orders = acheteur
  @orders = [] # init
  @all_orders = Order.all
  @all_orders.each do |order|
    if order.user_id == current_user
      @orders << order
      end
    end
    return @orders
end

def myorder
end

def show_achat
end

def new_achat
end

def edit_achat
end

def destroy_achat
end



end
