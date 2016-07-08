class Profile < ActiveRecord::Base
  belongs_to :user
  validates :user, presence: true

  def full_name
    [self.first_name, self.last_name].reject(&:blank?).join(' ')
  end
end
