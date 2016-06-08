class Profile < ActiveRecord::Base
  belongs_to :user
  # [review ] validates :user, presence: true
end
