class OrdersController < ApplicationController

def myorders
    @orders = Order.where(user_id: current_user)
    @orders_a_recup = Order.where(user_id: current_user, status: "en_cours")
    @orders_historique = Order.where(user_id: current_user, status: "livre")
end

def create
  @article = Article.find(params[:id])
  @order = Order.new(article_id: @article.id,
                      user_id: current_user.id,
                       status: :en_cours,
                       comment: "new order"
                       )
  if @order.save
    redirect_to myorders_path, notice: "Une commande a été créée"
  else
    render 'articles/index'
  end
end

def destroy
  @order = Order.find(params[:id])
  @order.destroy
  redirect_to myorders_path, notice: "La commande a été effacée"
end

def test
end

end

