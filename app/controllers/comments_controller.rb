class CommentsController < ApplicationController
    after_action :create_notifications, only:[:create]

    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.build(comment_params)
        @comment.user_id = current_user.id
        if @comment.save
            render :index
        end
    end
    
    def destroy
        @comment = Comment.find(params[:id])
        if @comment.destroy
            render :index
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:post_id, :user_id, :body)
    end

    def create_notifications
        return if @post.user.id == current_user.id
        Notification.create(user_id: @post.user.id, notified_by_id: current_user.id, post_id: @post.id, notified_type:"コメント")
    end
end