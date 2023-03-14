# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :find_post, only: %i[create]
  before_action :find_like, only: %i[destroy]

  def create
    like = current_user.likes.new(likes_params)
    authorize like
    if like.save
      @likes_count = @post.like.count
    else
      respond_to do |format|
        format.js { render 'create', locals: { error: like.errors.full_messages.to_sentence } }
      end
    end
  end

  def destroy
    authorize @like
    if @like.destroy
      @post = Post.find(@like.post_id)
      @likes_count = @post.like.count
    else
      respond_to do |format|
        format.js { render 'destroy', locals: { error: @like.errors.full_messages.to_sentence } }
      end
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def likes_params
    params.permit(:post_id)
  end

  def find_like
    @like = Like.find(params[:id])
  end
end
