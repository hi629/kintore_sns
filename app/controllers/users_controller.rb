class UsersController < ApplicationController
    before_action :authenticate_user!, except:[:show, :index]
    before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
    :following, :followers]

    def show
        @user = User.find(params[:id])
        @posts = @user.posts.all.order('created_at DESC')
    end

    def following
        @title = "Following"
        @user = User.find(params[:id])
        @users = @user.following
        render 'show_follow' #actionに対応するビューを呼び出すが、明示的にshow_followと記述し、show_followビューを表示させる
    end

    def followers
        @title = "Followers"
        @user = User.find(params[:id])
        @users = @user.followers
        render 'show_follow'
    end
end