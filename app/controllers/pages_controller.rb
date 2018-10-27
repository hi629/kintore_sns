class PagesController < ApplicationController
    def index
        @posts = Post.order("created_at DESC").paginate(:page => params[:page], :per_page => 21)
    end

    def search
        @posts = Post.order("created_at DESC").paginate(:page => params[:page], :per_page => 21).search(params[:search])
    end

    def about
    end
end