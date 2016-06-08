class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
  # [review]
  # validates :article, presence: true
  # validates :user, presence: true
  validates :body, presence: true
end
