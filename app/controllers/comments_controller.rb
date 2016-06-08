class CommentsController < ApplicationController
  before_action :set_article
  before_action :authenticate_user!

  def create
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
    else
      render :error
    end
  end

  def destroy
    # [reviwe] @article.comments.find(params[:id])
    # before_action に set_comment を用意してそちらでやることが多いです。
    @comment = Comment.find(params[:id])

    # [review] 任意のコメントを消すことが出来るのでは？
    if @comment.destroy
    else
      render :error
    end
  end

  private
    def set_article
      @article = Article.find(params[:article_id])
    end

    def comment_params
      params.require(:comment).permit(:body, :article_id)
    end
end
