# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :likes, dependent: :destroy
  has_many :stories, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :image, dependent: :destroy
  has_many :connections_sent, foreign_key: 'sender_id', class_name: 'Follower', dependent: :destroy, inverse_of: :sender
  has_many :connections_recieved, foreign_key: 'reciever_id', class_name: 'Follower', dependent: :destroy, inverse_of: :reciever

  scope :request_status_check, ->(current_user, user_id) { current_user.connections_sent.find_by(reciever_id: user_id) }
  scope :following_ids, lambda { |current_user, status|
                          current_user.connections_sent.where(request_status: status)
                        }
  scope :request_recieved, lambda { |current_user|
                             where(id: current_user.connections_recieved.where(request_status: 'pending').pluck(:sender_id))
                           }

  validates :email, format: { with: /([a-zA-Z0-9]+)([_.\-{1}])?([a-zA-Z0-9]+)@([a-zA-Z0-9]+)(\.)([a-zA-Z.]+)/,
                              message: 'invalid' }
  validate :correct_image_mime_type?
  validates :firstname, :lastname, presence: true

  def correct_image_mime_type?
    return unless image.attached? && !image.content_type.in?(%w[image/png image/gif image/jpeg])

    errors.add(:image, 'Image Must be a PNG or a GIF file')
  end
end
