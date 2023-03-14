# frozen_string_literal: true

class Post < ApplicationRecord
  before_create :check_images_size

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :like, dependent: :destroy
  has_many_attached :images, dependent: :destroy

  validates :content, :images, presence: true
  validate :check_images_size, on: :create

  scope :following_posts, lambda { |current_user, following_ids|
                            includes(:comments).where(user_id: following_ids).or(own_posts(current_user))
                          }
  scope :own_posts, lambda { |current_user|
    includes(:comments).where(user_id: current_user.id)
  }

  private

  def check_images_size
    errors.add('post', 'image size greate then 10') unless images.size <= 10
  end
end
