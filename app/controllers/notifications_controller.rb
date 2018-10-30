class NotificationsController < ApplicationController
  before_action :authenticate_user!, only:[:list]

  def list
    @notifications = current_user.notifications.includes(:notified_by)
  end

  def link_through
    @notification = Notification.find(params[:id])
    @notification.destroy
    redirect_to post_path @notification.post
  end
end
