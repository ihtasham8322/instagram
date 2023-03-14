# frozen_string_literal: true

class Story < ApplicationRecord
  validates :content, :images, presence: true
  belongs_to :user
  has_many_attached :images, dependent: :destroy
  after_create :destroy_call

  private

  scope :following_stories, lambda { |current_user, following_ids|
                              where(user_id: following_ids).or(own_stories(current_user))
                            }
  scope :own_stories, lambda { |current_user|
    where(user_id: current_user.id)
  }

  def destroy_call
    DeleteStoryJob.set(wait: 24.hours).perform_later(id)
  end
end
