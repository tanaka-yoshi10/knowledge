class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]
  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)

    if @article.save
      render :show, status: :created, location: @article
    else
      render :new
    end
  end

  def show
  end

  private
  def set_article
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
