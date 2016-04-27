class Article < ActiveRecord::Base
  belongs_to :author, class_name: User
  has_many :stocks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :taggings, foreign_key: :taggable_id
  has_many :tags, through: :taggings
  validates :title, presence: true
  validates :body, presence: true
  enum status: { draft: 0, published: 1 }

  def tag_list
    self.tags.map(&:name)
  end

  def tag_list=(value)
    new_tags = value.split(',')

    delete_tags(self.tag_list - new_tags)
    add_tags(new_tags - self.tag_list)
  end

  private
  def add_tags(tags)
    tags.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
      tagging = self.taggings.build(tag: tag)
      tagging.save # TODO: エラーは無視？
    end
  end

  def delete_tags(tags)
    tags.each do |tag_name|
      tag = Tag.find_by(name: tag_name)
      tagging = self.taggings.find_by(tag: tag)
      tagging.destroy # TODO: エラーは無視？
    end
  end
end
