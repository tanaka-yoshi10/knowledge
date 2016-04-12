class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :check_draft, only: [:show, :edit, :update, :destroy]
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

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @article.destroy! # TODO !をつける？つけない？
    # TODO 関連するデータを削除 tag stock
    redirect_to current_user, notice: 'Article was successfully destroyed.'
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end

  def check_draft
    if @article.draft? && @article.author != current_user
      redirect_to root_path, notice: 'この記事は下書きです'
    end
  end

  def article_params
    params.require(:article).permit(:title, :body, :tag_list, :status)
  end
end
