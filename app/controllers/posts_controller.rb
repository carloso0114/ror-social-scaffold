class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    timeline_posts
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      timeline_posts
      render :index, alert: 'Post was not created.'
    end
  end

  private

  def timeline_posts
    @timeline_posts = Post.all.where(user_id: current_user.id)
    @all_friends = Friendship.where(user_id: current_user.id, confirmed: true)

    @all_friends.each do |friend|
      @timeline_posts += Post.where(user_id: friend.friend_id)
    end
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
