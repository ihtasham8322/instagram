# frozen_string_literal: true

class UserController < ApplicationController
  before_action :find_user, only: %i[update edit show]
  before_action :authorize_user, only: %i[update edit show]
  def index
    authorize current_user
    @posts = Post.includes(:comments).where(user_id: current_user.id)
    @user = current_user
  end

  def edit; end

  def update
    if @user.update(image_params)
      flash[:notice] = 'Updated profile image'
      redirect_to user_index_path
    else
      flash[:notice] = @user.errors.full_messages.to_sentence
      render :edit
    end
  end

  def show
    @comment = Comment.new
    @pagy, @posts = pagy(Post.where(user_id: params[:id]))
  end

  def search
    @users = User.where('firstname ILIKE?', "%#{params[:q]}%")
  end

  def account_privacy
    user = User.find(params[:id])
    user.public = user.public? ? false : true
    flash[:notice] = user.save ? 'Privacy changed' : user.errors.full_messages.to_sentence
    redirect_to user_index_path
  end

  private

  def post_params
    params.require(:post).permit(:content, images: [])
  end

  def image_params
    params.require(:user).permit(:image)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def authorize_user
    authorize @user
  end
end
