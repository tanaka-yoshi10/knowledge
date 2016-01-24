class Tag < ActiveRecord::Base
  has_many :tagfollows
  has_many :users, through: :tagfollows
end

