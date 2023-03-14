# frozen_string_literal: true

class PostController < ApplicationController
  before_action :find_post, only: %i[update edit destroy]
  before_action :authorize_user, only: %i[update edit destroy]

  def index
    @comment = Comment.new
    following_ids = User.following_ids(current_user, 'accepted').pluck(:reciever_id)
    @posts = Post.following_posts(current_user, following_ids)
    @stories = Story.following_stories(current_user, following_ids)
    @users_requests = User.where(id: User.request_recieved(current_user))
  end

  def new
    @post = Post.new
  end

  def create
    post = current_user.posts.build(post_params)
    authorize post
    flash[:notice] = if post.save
                       'Your post has been saved'
                     else
                       post.errors.full_messages.to_sentence
                     end
    redirect_to post_index_path
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Your post updated'
      redirect_to user_index_path
    else
      flash[:notice] = @post.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  def destroy
    flash[:notice] = @post.destroy ? 'Your post is deleted.' : @post.errors.full_messages.to_sentence
    redirect_to user_index_path
  end

  private

  def post_params
    params.require(:post).permit(:content, images: [])
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def authorize_user
    authorize @post
  end
end
