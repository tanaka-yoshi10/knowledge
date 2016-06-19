class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:twitter, :github]

  has_many :articles, foreign_key: :author_id, dependent: :destroy
  has_many :stocks, dependent: :destroy
  has_many :relationships, foreign_key: :follower_id, dependent: :destroy
  has_many :reverse_relationships, class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :tagfollows, dependent: :destroy
  has_many :tags, through: :tagfollows
  has_many :stocking_articles, through: :stocks, source: :article
  has_one :profile, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth["provider"], uid: auth["uid"]) do |user|
      user.name = auth.info.nickname
      user.email = auth.info.email
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

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    # OAuthで登録した場合パスワードが無い。そのような場合でもプロフィール変更を可能にする。
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def stock!(article)
    stocks.find_or_create_by!(article: article)
  end

  def unstock!(article)
    stocks.find_by(article: article).destroy!
  end

  def stocking?(article)
    stocks.find_by(article: article).present?
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy!
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

  def feed
    Article.from_tags_followed_by(self)
    # TODO: 現時点ではフォローしているタグの記事の表示まで(フォローしているユーザに関する情報には未対応)
  end
end
