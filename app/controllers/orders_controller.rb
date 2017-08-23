class OrdersController < ApplicationController

  before_action :set_order, only: [:destroy, :change_statut]

  def myorders
    @status = params[:status]
    @order = Order.new
    @order.status = params[:status]
    if @order.en_cours?
      @orders = current_user.orders.en_cours
      render 'a'
    elsif @order.a_preparer?
      @orders = current_user.orders.a_preparer
      render '_b'
    elsif @order.confirme?
      @orders = current_user.orders.confirme
      render '_c'
    elsif @order.livre?
      @orders = current_user.orders.livre
      render '_d'
    end
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
    @orders_a_preparer = []
    @orders_livre =[]
    @orders_termine = []
    # garder les orders dont les articles <=> articles du user
    @orders.each do |order|
    @array_articles.each do |a|
      if order.article_id == a
        if order.a_preparer?
          @orders_a_preparer << order
        elsif order.confirme?
          @orders_livre << order
        elsif order.livre?
          @orders_termine << order
        end
      end
    end
  end
end

def change_statut
  @order.status = params[:status]
  @order.save!
  if @order.a_preparer?
    redirect_to  myorders_path, notice: "La commande est confirmée! Le vendeur la prépare..."
  elsif @order.confirme?
    redirect_to  myorders_path, notice: "La commande est préparée"
  elsif @order.livre?
    redirect_to  myorders_path, notice: "La commande a été récupérée"
  elsif @order.annulle?
    redirect_to  myorders_path, notice: "La commande est annulée"
  end
end

def set_order
  @order = Order.find(params[:id])
end

def display
  render 'orders/a', orders: @orders
end


end

