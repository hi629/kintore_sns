class PostsController < ApplicationController
    before_action :set_post, only:[:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except:[:show]

    def index
        @posts_all = Post.all.includes(:user, :like_users) # include...N+1問題対策にgem bullet利用
        @following_users = current_user.following
        @posts = @posts_all.where(user_id:@following_users).order("created_at DESC")
    end

    def show
        @post = Post.find(params[:id])
        @user = @post.user
        @comment = Comment.new
        @comments = @post.comments
    end

    def new
        @post = current_user.posts.build
    end

    def hashtags
        @tag = Tag.find_by(name:params[:name])
        @posts = @tag.posts
    end

    def search
    end

    def edit
        @post = Post.find(params[:id])
    end

    def create
        @post = current_user.posts.build(post_params)
        if @post.save
            redirect_to root_path, notice:"投稿しました"
        else
            render :new
        end
    end

    def update
    end

    def destroy
        @post.destroy
        redirect_to root_path, alert:"削除しました"
    end

    private

    def set_post
        @post = Post.find(params[:id])
    end

    def post_params
        params.require(:post).permit(:text, :image)
    end

end
