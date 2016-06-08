class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :taggable, class_name: Article
  # [review ] validates :tag, presence: true
  # [review ] validates :taggable, presence: true
end
