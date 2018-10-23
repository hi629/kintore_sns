class PagesController < ApplicationController
    def index
        @posts = Post.all.order("created_at DESC")
    end

    def search
        @posts = Post.all.search(params[:search])
    end

    def about
    end
end