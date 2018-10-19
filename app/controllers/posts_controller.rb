class PostsController < ApplicationController
    before_action :set_post, only:[:show, :edit, :update, :destroy]

    def index
        @posts = Post.all.order("created_at DESC")
    end

    def show
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
