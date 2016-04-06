class Article < ActiveRecord::Base
  belongs_to :author, class_name: User
  has_many :stocks, dependent: :destroy
  has_many :comments, dependent: :destroy
  acts_as_ordered_taggable_on :tags
  validates :title, presence: true
  validates :body, presence: true
end
