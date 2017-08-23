class ArticlesController < ApplicationController

  before_action :set_article, only: [:update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :search]
  after_action :flash_nil, only: :index

  def flash_nil
    flash[:notice] = nil
  end

  def index

    flash[:notice] = "Veuillez vous connecter pour commander" if current_user.nil?

    @articles = Article.actif.order(id: :desc)

    if params[:format].nil?
      @article = Article.new
    else
      @article = Article.find(params[:format])
    end
  end

  def create
    @article = Article.new(article_params)
    @article.active = :actif
    @article.user = current_user
    if @article.save
      redirect_to articles_path, notice: "L'article a été créé avec beaucoup de succès"
    else
      render :index
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to articles_path, notice: "L'article a été mis à jour"
    else
      render :index
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to mysales_path, notice: "L'article a été effacé ainsi que toutes les commandes qui lui sont liées"
  end

  def search
    params[:query].downcase!
    if params[:query] == ""
      redirect_to articles_path
    else
      @articles = Article.where('name LIKE :search', search: "%#{params[:query]}%")
      if @articles == nil
        @articles = Article.where('description LIKE :search', search: "%#{params[:query]}%")
      end
      flash[:notice] = "Veuillez vous connecter pour commander" if current_user.nil?
      render :index
    end
    # search = params[:query]
    # @results = ActiveRecord::Base.connection.execute("SELECT * FROM articles WHERE name = '#{search}'")
    # @articles = @results.to_a
    # redirect_to articles_search_path
  end


  private

  def set_article
    @article = Article.find(params[:id])

  end

  def article_params
    params.require(:article).permit(:name, :description, :quantity, :unit, :image, :price, :delivery_date, :photo)

  end



end
