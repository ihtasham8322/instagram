# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :find_comment, only: %i[update edit destroy]
  before_action :authorize_user, only: %i[update edit destroy]

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.build(comment_params)
    authorize @comment
    respond_to do |format|
      if @comment.save
        format.js
      else
        format.js { render 'create', locals: { error: @comment.errors.full_messages.to_sentence } }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @comment.update(update_params)
        format.js
      else
        format.js { render 'update', locals: { error: @comment.errors.full_messages.to_sentence } }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @comment.destroy
        format.js
      else
        format.js { render 'destroy', locals: { error: @comment.errors.full_messages.to_sentence } }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end

  def update_params
    params.require(:comment).permit(:content)
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def authorize_user
    authorize @comment
  end
end
