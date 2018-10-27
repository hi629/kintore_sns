class NotificationsController < ApplicationController
  before_action :authenticate_user!, only:[:list]

  def list
    @notifications = current_user.notifications
  end

  def link_through
    @notification = Notification.find(params[:id])
    @notification.update read: true
    redirect_to post_path @notification.post
  end
end
