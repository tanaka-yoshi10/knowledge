class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :taggable, class_name: Article
  validates :tag, presence: true
  #validates :taggable, presence: true
  # FIXME: Articleのcreate時にタグを指定していると、validationに失敗する(Taggingsは不正な値です)ため、 コメントアウトしている
end
