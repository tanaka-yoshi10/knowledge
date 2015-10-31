class PagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @articles = Article.all.includes(:user) # TODO: 公開のみにする
  end
end
