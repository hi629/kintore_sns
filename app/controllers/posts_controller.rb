class PostsController < ApplicationController
    before_action :set_post, only:[:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except:[:show]

    def index
        @posts_all = Post.all.includes(:user) # include...N+1問題対策にgem bullet利用
        @following_users = current_user.following
        @posts = @posts_all.where(user_id:@following_users).order("created_at DESC")
    end

    def show
        @post = Post.find(params[:id])
        @user = @post.user
    end

    def new
        @post = current_user.posts.build
    end

    def edit
    end

    def create
        @post = current_user.posts.build(post_params)
        if @post.save
            redirect_to root_path, notice:"Post was successfully created."
        else
            render :new
        end
    end

    def update
    end

    def destroy
        @post.destroy
        redirect_to posts_url, notice:"post was successfully destroyed"
    end

    private

    def set_post
        @post = Post.find(params[:id])
    end

    def post_params
        params.require(:post).permit(:text, :image)
    end

end
