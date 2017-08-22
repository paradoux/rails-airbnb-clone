class OrdersController < ApplicationController

  def myorders
    # achats en cours (statut = en_cours)
    @orders = Order.en_cours.where(user_id: current_user)
    # achats en cours de prepa
    @orders_prepa = Order.a_preparer.where(user_id: current_user)
    # achats à récupérer (a_preparer + confirme)
    @orders_a_recup = Order.confirme.where(user_id: current_user)
    # achats termines
    @orders_historique = Order.livre.where(user_id: current_user)
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
  # acheteur confirme order --> order passe du statut en_cours à a_preparer
  @order = Order.find(params[:id])
  @order.status = :a_preparer
  # retour à la page des achats
  redirect_to my_orders_path
end


end

