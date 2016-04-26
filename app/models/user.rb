class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:twitter]
  has_many :articles, foreign_key: :author_id
  has_many :stocks
  has_many :relationships, foreign_key: :follower_id, dependent: :destroy
  has_many :reverse_relationships, class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy
  # TODO 上の文字列はシンボルにできないのか？
  has_many :followed_users, through: :relationships, source: :followed
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :tagfollows, dependent: :destroy
  has_many :tags, through: :tagfollows
  has_many :stocking_articles, through: :stocks, source: :article
  validates :name, presence: true, uniqueness: true

  def self.from_omniauth(auth)
    where(provider: auth["provider"], uid: auth["uid"]).first_or_create do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
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
    stocks.find_or_create_by!(article: article)
  end

  def unstock!(article)
    stocks.find_by(article: article).destroy
  end

  def stocking?(article)
    stocks.find_by(article: article).present?
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id).present?
  end

  def follow_tag!(tag)
    tagfollows.find_or_create_by!(tag: tag)
  end

  def unfollow_tag!(tag)
    tagfollows.find_by(tag: tag).destroy!
  end

  def following_tag?(tag)
    tagfollows.find_by(tag: tag).present?
  end

  def contribution
    self.articles.joins(:stocks).count
  end
end
