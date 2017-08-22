class OrdersController < ApplicationController

  def myorders
    # achats en cours (statut = en_cours)
    @orders = current_user.orders.en_cours
    # achats en cours de prepa
      @orders_prepa = current_user.orders.a_preparer
    # achats à récupérer (a_preparer + confirme)
      @orders_a_recup = current_user.orders.confirme
    # achats termines
      @orders_historique = current_user.orders.livre
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

def acheteur_confirme
  @order = Order.find(params[:id])
  @order.confirme!
  redirect_to  myorders_path, notice: "La commande est confirmée! Le vendeur la prépare..."
end

end

