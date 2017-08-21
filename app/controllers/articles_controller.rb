class ArticlesController < ApplicationController

  before_action :set_article, only: [:update, :destroy]

  def index
    @articles = Article.order(active: :desc, id: :desc)

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
    redirect_to articles_path, notice: "L'article a été effacé ainsi que toutes les commandes qui lui sont liées"
  end

  private

  def set_article
    @article = Article.find(params[:id])

  end

  def article_params
    params.require(:article).permit(:name, :description, :quantity, :unit, :image, :price, :delivery_date)

  end

end
