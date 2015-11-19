class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:twitter]
  has_many :articles
  has_many :stocks
  has_many :relationships, foreign_key: :follower_id, dependent: :destroy
  has_many :reverse_relationships, class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy
  # TODO 上の文字列はシンボルにできないのか？
  has_many :followed_users, through: :relationships, source: :followed
  has_many :followers, through: :reverse_relationships, source: :follower
  validates :username, presence: true, uniqueness: true

  def self.from_omniauth(auth)
    where(provider: auth["provider"], uid: auth["uid"]).first_or_create do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.username = auth["info"]["nickname"]
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def stock!(article)
    stocks.create!(article: article)
  end

  def unstock!(article)
    stocks.find_by(article: article).destroy
  end

  def stocking?(article)
    stocks.find_by(article: article)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end
end
