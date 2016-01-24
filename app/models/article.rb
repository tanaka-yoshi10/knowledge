class Article < ActiveRecord::Base
  belongs_to :user
  has_many :stocks, dependent: :destroy
  has_many :comments, dependent: :destroy
  acts_as_ordered_taggable_on :tags
  validates :title, presence: true
  validates :body, presence: true

  # scopeにすべき？
  def self.stocked_by(user)
    stocked_article_ids = "SELECT article_id FROM stocks WHERE user_id = :user_id"
    where("articles.id IN (#{stocked_article_ids})", user_id: user.id)
  end
end
