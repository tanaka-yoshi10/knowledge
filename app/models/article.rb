class Article < ActiveRecord::Base
  extend Enumerize

  belongs_to :author, class_name: User
  has_many :stocks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :taggings, foreign_key: :taggable_id, dependent: :destroy, autosave: true
  has_many :tags, through: :taggings

  validates :title, presence: true
  validates :body, presence: true
  validates :author, presence: true

  enumerize :status, in: { draft: 0, published: 1 }, scope: true, predicates: true
  default_scope -> { order(created_at: :desc) }
  scope :published, -> { with_status(:published) }
  scope :draft, -> { with_status(:draft) }

  def self.tagged_with(tag_name)
    Tag.find_by(name: tag_name).articles
  end

  def tag_list
    self.tags.pluck(:name)
  end

  def tag_list=(value)
    new_tags = value.split(',').map(&:strip)

    delete_tags(self.tag_list - new_tags)
    add_tags(new_tags - self.tag_list)
  end

  def self.from_tags_followed_by(user)
    # TODO: 改善できそうな気がする
    tag_ids = "SELECT tag_id FROM tagfollows WHERE user_id = :user_id"
    article_ids = "SELECT taggable_id FROM taggings WHERE tag_id IN (#{tag_ids})"
    where("id IN (#{article_ids})", user_id: user.id)
  end

  private
  def add_tags(tags)
    tags.each do |tag_name|
      tag = Tag.find_or_initialize_by(name: tag_name)
      self.taggings.build(tag: tag)
    end
  end

  def delete_tags(tags)
    tags.each do |tag_name|
      tag = Tag.find_by(name: tag_name)

      # 本当はfind_byにしたかったが、別オブジェクトを生成するためmark_for_destructionが有効にならず
      # save時にtaggingがdeleteとされなかったためfind_byを諦めた
      # tagging = self.taggings.find_by(tag: tag)
      tagging = self.taggings.find{|tagging| tagging.tag_id == tag.id}
      tagging.mark_for_destruction
    end
  end
end
