class Tag < ActiveRecord::Base
  has_many :tagfollows, dependent: :destroy
  has_many :users, through: :tagfollows
  has_many :taggings, dependent: :destroy
  has_many :articles, through: :taggings, source: :taggable

  def self.most_used_in_published
    joins(:articles)
      .merge(Article.published)
      .group(:id)
      .select('tags.id, tags.name, COUNT(tags.id) as taggings_count')
      .order('taggings_count DESC')
  end
end
