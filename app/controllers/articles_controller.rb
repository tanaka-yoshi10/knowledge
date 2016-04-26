class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]
  before_action :check_draft, only: [:show, :edit, :update, :destroy]
  before_action :check_author, only: [:edit, :update, :destroy]

  def index
    @articles = Article.published.order(:created_at).reverse_order.includes(:author).page(params[:page])
  end

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
    redirect_to current_user, notice: 'Article was successfully destroyed.'
    # TODO: redirect先を再考
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

  def check_author
    if @article.author != current_user
      redirect_to root_path, notice: 'この記事を編集できるのは著者のみです'
    end
  end

  def article_params
    params.require(:article).permit(:title, :body, :tag_list, :status)
  end
end
