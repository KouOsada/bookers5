class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # リレーション
  has_many :books, dependent: :destroy
  attachment :profile_image, destroy: false
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  # フォロー機能
  # [被フォロー]
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # [与フォロー]
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # [被フォローを通じて参照→自分をフォローしている人]
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # [与フォローを通じて参照→自分がフォローしている人]
  has_many :followings, through: :relationships, source: :followed
  # メソッド追加
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  
  def following?(user)
    followings.include?(user)
  end
  # メソッドここまで
  
  # バリデーション
  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
end
