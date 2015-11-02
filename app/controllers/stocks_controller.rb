class StocksController < ApplicationController
  def create
    article = Article.find(params[:article_id])
    stock = current_user.stocks.build do |s|
      s.article = article
    end
    stock.save
    redirect_to article
  end

  def destroy
    stock = Stock.find(params[:id])
    stock.destroy
    article = Article.find(params[:article_id])
    redirect_to article
  end
end
