class Tagging < ActiveRecord::Base
  belongs_to :tag
  counter_culture :tag, column_name: ->(tagging) do
    if tagging.taggable.published?
      :taggings_count
    else
      nil
    end
  end
  belongs_to :taggable, class_name: Article
  validates :tag, presence: true
  #validates :taggable, presence: true
  # FIXME: Articleのcreate時にタグを指定していると、validationに失敗する(Taggingsは不正な値です)ため、 コメントアウトしている
end
