class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:twitter]
  has_many :articles
  has_many :stocks
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
    stock = stocks.build do |s|
      s.article = article
    end
    stock.save!
  end

  def unstock!(article)
    stock = stocks.find_by(article_id: article.id)
    stock.destroy
  end

  def stocking?(article)
    self.stocks.any?{|s| s.article_id == article.id}
  end
end
