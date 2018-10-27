class Post < ApplicationRecord
    belongs_to :user
    mount_uploader :image, ImageUploader
    validates :image, presence: true
    has_many :likes, dependent: :destroy
    has_many :like_users, through: :likes, source: :user

    has_many :comments, dependent: :destroy
    
    has_and_belongs_to_many :tags

    after_create do
        post = Post.find_by(id: self.id)
        hashtags  = self.text.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
        hashtags.uniq.map do |hashtag|
          tag = Tag.find_or_create_by(name: hashtag.downcase.delete('[#＃]'))
          post.tags << tag
        end
    end

    before_update do 
        post = Post.find_by(id: self.id)
        post.tags.clear
        hashtags = self.text.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
        hashtags.uniq.map do |hashtag|
          tag = Tag.find_or_create_by(name: hashtag.downcase.delete('[#＃]'))
          post.tags << tag
        end
    end

    def self.search(search)
        if search
            where(['text LIKE ?', "%#{search}%"]) 
        else
            all
        end
    end

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
