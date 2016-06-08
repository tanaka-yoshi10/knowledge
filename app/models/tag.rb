class Tag < ActiveRecord::Base
  # [review] dependent: :destroy の指定は必要ないですか？
  has_many :tagfollows
  has_many :users, through: :tagfollows
  # [review] dependent: :destroy の指定は必要ないですか？
  has_many :taggings
  has_many :articles, through: :taggings, source: :taggable

  # [review] scopeではなくメソッドにするべきかなと思います。
  scope :most_used_in_published, -> {
    # [review] こういうケースではcounter_cache使ったほうが楽な気がします。
    joins(:articles)
      .where('articles.status = ?', Article.statuses[:published])
      .group(:id)
      .select('tags.id, tags.name, COUNT(tags.id) as taggings_count')
      .order('taggings_count DESC')
  }
end
