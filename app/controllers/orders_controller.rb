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
# param du form
    if params[:format].nil?
      @article = Article.new
    else
      @article = Article.find(params[:format])
    end

    # articles en cours de vente pour le user
      @articles = Article.where(user_id: current_user)
      @array_articles = []
      # contruire array qui contient tous les articles du user
      @articles.each do |article|
        @array_articles << article.id
      end
    @orders = Order.all
    @orders_in_sale = []
    @orders_livre =[]
    # garder les orders dont les articles <=> articles du user
    @orders.each do |order|
    @array_articles.each do |a|
      if order.article_id == a
        if order.a_preparer?
          @orders_in_sale << order
        elsif order.livre?
          @orders_livre << order
        end
      end
    end
  end
end


end

