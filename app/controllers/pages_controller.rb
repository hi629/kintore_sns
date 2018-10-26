class PagesController < ApplicationController
    def index
        @posts = Post.order(created_at: :desc).page(params[:page]).per(20)
        # @posts = Post.page(params[:page]).per(50)
    end

    def search
        @posts = Post.all.search(params[:search])
    end

    def about
    end
end