class LikesController < ApplicationController
  before_action :logged_in_user
  after_action :create_notifications, only:[:create]

  def create
    @post = Post.find(params[:post_id])
    unless @post.like?(current_user)
      @post.like(current_user)
      @post.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end

  def destroy
    @post = Like.find(params[:id]).post
    if @post.like?(current_user)
      @post.dislike(current_user)
      @post.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end

  private 

  def create_notifications
    return if @post.user.id == current_user.id
    Notification.create(user_id: @post.user.id, notified_by_id: current_user.id, post_id:@post.id, notified_type:"いいね")
  end
end