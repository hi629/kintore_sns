class Post < ApplicationRecord
    belongs_to :user
    mount_uploader :image, ImageUploader
    validates :image, presence: true
    has_many :likes, dependent: :destroy
    has_many :like_users, through: :likes, source: :user

    def like(user)
        likes.create(user_id:user.id)
    end

    def dislike(user)
        likes.find_by(user_id: user.id).destroy
    end

    def like?(user)
        like_users.include?(user)
    end
end
