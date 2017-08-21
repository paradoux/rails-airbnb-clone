class OrdersController < ApplicationController

def my_achats_index
  @orders = [] # init
  @all_orders = Order.all
  @all_orders.each do |order|
    if order.user_id == current_user
      @orders << order
      end
    end
    return @orders
end

def test
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
