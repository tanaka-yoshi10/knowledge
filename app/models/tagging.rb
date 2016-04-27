class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :taggable, class_name: Article
end
