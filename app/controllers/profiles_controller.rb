class ProfilesController < ApplicationController
    before_action :authenticate_user!

    def show
        @posts = current_user.posts.all.order('created_at DESC')
    end
end