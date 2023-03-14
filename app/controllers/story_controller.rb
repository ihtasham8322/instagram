# frozen_string_literal: true

class StoryController < ApplicationController
  before_action :find_story, only: %i[destroy]
  def new
    @story = Story.new
  end

  def create
    story = current_user.stories.build(post_params)
    authorize story
    flash[:notice] = story.save ? 'Your story created' : story.errors.full_messages.to_sentence
    redirect_to post_index_path
  end

  def show
    @stories = Story.where(id: params[:id])
    return record_not_found if @stories.blank?

    authorize @stories
  end

  def destroy
    authorize @story
    flash[:notice] = @story.destroy ? 'Deleted story' : @story.errors.full_messages.to_sentence
    redirect_to post_index_path
  end

  private

  def post_params
    params.require(:story).permit(:content, images: [])
  end

  def find_story
    @story = Story.find(params[:id])
  end
end
