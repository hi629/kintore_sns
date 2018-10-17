class PostsController < ApplicationController
    def index
        @post = Post.all
    end

    def new
        @post = Post.new
    end

    def edit
    end

    def create
        @post = Post.new(post_params)
    end

    def delete
    end

    private

    def post_params
        params.require(:post).permit(:text)
    end

end
