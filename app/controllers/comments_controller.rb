class CommentsController < ApplicationController
  before_action :set_article
  before_action :set_comment, except: [:create]
  before_action :authenticate_user!
  before_action :comment_owner!, only: [:destroy]

  def create
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
    else
      render :error
    end
  end

  def destroy
    @comment.destroy
  end

  private
    def set_article
      @article = Article.find(params[:article_id])
    end

    def set_comment
      @comment = @article.comments.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body, :article_id)
    end

    def comment_owner!
      if @comment.user != current_user
        render :status => :forbidden
      end
    end
end
