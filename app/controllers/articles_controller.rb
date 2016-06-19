class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]
  before_action :require_author_if_draft, only: [:show]
  before_action :check_author, only: [:edit, :update, :destroy]

  def index
    @q = Article.ransack(params[:q])
    @articles = @q.result(distinct: true).published.order(created_at: :desc).includes([:author, :tags]).page(params[:page])
  end

  def show
  end

  def new
    @article = current_user.articles.build
  end

  def edit
  end

  def create
    @article = current_user.articles.build(article_params)

    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to root_url, notice: 'Article was successfully destroyed.'
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end

  def require_author_if_draft
    if @article.draft? && @article.author != current_user
      redirect_to root_url, notice: 'この記事は下書きです'
    end
  end

  def check_author
    if @article.author != current_user
      redirect_to @article, notice: 'この記事を編集できるのは著者のみです'
    end
  end

  def article_params
    params.require(:article).permit(:title, :body, :tag_list, :status)
  end
end
