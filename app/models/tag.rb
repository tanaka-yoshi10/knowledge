class Tag < ActiveRecord::Base
  has_many :tagfollows
  has_many :users, through: :tagfollows
  has_many :taggings
  has_many :articles, through: :taggings, source: :taggable

  # TODO: acts-as-taggable-onをうまく活用できなかったため、SQLを直接発行して実現している。見直したい。
  scope :most_used_in_published, -> {
    joins('INNER JOIN taggings ON tags.id = taggings.tag_id')
      .joins('INNER JOIN articles ON taggings.taggable_id = articles.id AND taggings.taggable_type = "Article"')
      .group(:id)
      .order('taggings_count DESC')
      .where('articles.status = ?', Article.statuses[:published])
      .select('tags.id, tags.name, COUNT(tags.id) as taggings_count')
  }
end
