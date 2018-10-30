class User < ApplicationRecord
  # validates :username, presence: true
  # validates_uniqueness_of :username
  # validates :name, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # current_passwordなしで更新
  attr_accessor :current_password

  has_many :comments, dependent: :destroy
  
  mount_uploader :avatar, ImageUploader
         
  has_many :posts, :dependent=>:destroy
  has_many :active_relationships, class_name:"Relationship", foreign_key:"follower_id", dependent: :destroy
  has_many :passive_relationships, class_name:"Relationship", foreign_key:"followed_id", dependent: :destroy
  
  has_many :following, through: :active_relationships, source: :followed #followedsは英語的におかしいので、source: :followedと明示的に別記する。
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :likes, dependent: :destroy

  has_many :notifications, dependent: :destroy

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    clean_up_passwords
    update_attributes(params, *options)
  end
end
