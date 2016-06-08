class Article < ActiveRecord::Base
  belongs_to :author, class_name: User
  has_many :stocks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :taggings, foreign_key: :taggable_id
  has_many :tags, through: :taggings

  # [review] ↓のように丁寧にチェックをかけたほうがアプリの作りが固くなります
  # validates :author, presence: true
  validates :title, presence: true
  validates :body, presence: true

  enum status: { draft: 0, published: 1 }

  # [review] チェーンできないものはscopeではなくメソッドにするのが適切です。
  scope :tagged_with, ->(tag_name) {
    Tag.find_by(name: tag_name).articles
  }

  def tag_list
    # [review] self.tags.pluck(:name) の方が効率的です。
    self.tags.map(&:name)
  end

  def tag_list=(value)
    # [review] 前後の余計なスペースを除去したい気がします。
    # 【tag1, tag2, tag3】といった入力も許容してほしいです。
    new_tags = value.split(',')

    # [review] tag_listに代入するだけでsaveやdestroyが発生するのは怖いです。
    # 出来ればsaveのタイミングで何とかしたいところ
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
