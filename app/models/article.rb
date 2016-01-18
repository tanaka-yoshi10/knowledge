class Article < ActiveRecord::Base
  belongs_to :user
  has_many :stocks
  acts_as_ordered_taggable_on :tags

  # scopeにすべき？
  def self.stocked_by(user)
    stocked_article_ids = "SELECT article_id FROM stocks WHERE user_id = :user_id"
    where("articles.id IN (#{stocked_article_ids})", user_id: user.id)
  end
end
