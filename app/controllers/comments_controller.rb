class CommentsController < ApplicationController
  before_action :set_article
  before_action :authenticate_user!

  def create
    comment = @article.comments.build(comment_params)
    comment.user = current_user

    if comment.save
      redirect_to @article, notice: 'Comment was successfully created.'
    else
      # TODO comment投稿NGの場合の処理
      redirect_to @article, alert: 'Comment was failed'
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to @article, notice: 'Comment was successfully destroyed.'
  end

  private
    def set_article
      @article = Article.find(params[:article_id])
    end

    def comment_params
      params.require(:comment).permit(:body, :article_id)
    end
end
