# frozen_string_literal: true

class DeleteStoryJob < ApplicationJob
  queue_as :default

  def perform(id)
    Story.destroy(id) if Story.exists?(id)
  end
end
