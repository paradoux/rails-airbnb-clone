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


  def mysales
  # todo
  @orders = Order.all
# articles qui correspondent au user
@articles = Article.where(user_id: current_user)
# array avec les articles id du user
@orders.each do |order|
  @articles.each do |a|
    if order.article.id == a
      @orders_in_sale << order
    end
  end
end
    if params[:format].nil?
      @article = Article.new
    else
      @article = Article.find(params[:format])
    end
end


end

