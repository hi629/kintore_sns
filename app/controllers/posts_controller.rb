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
        @comments = @post.comments.includes(:user)
    end

    def new
        @post = current_user.posts.build
    end

    def hashtags
        @tag = Tag.find_by(name:params[:name])
        @posts = @tag.posts.order("created_at DESC").paginate(:page => params[:page], :per_page => 21)
    end

    def search
    end

    def edit
        @post = Post.find(params[:id])
    end

    def create
        @post = current_user.posts.build(post_params)

        respond_to do |format|
            if @post.save
                format.html { redirect_to root_path, notice:"投稿しました" }
                format.json { render :show, status: :created, location: @post }
            else
                format.html { render :new }
                format.json { render json: @post.errors, status: :unprocessable_entity }
            end            
        end
    end

    def update
    end

    def destroy
        @post.destroy
        respond_to do |format| 
            format.html { redirect_to root_path, alert:"削除しました" }
            format.json { head :no_content }
        end
        
    end

    private

    def set_post
        @post = Post.find(params[:id])
    end

    def post_params
        params.require(:post).permit(:text, :image)
    end

end
