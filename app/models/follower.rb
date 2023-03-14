# frozen_string_literal: true

class Follower < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :reciever, class_name: 'User'

  scope :request_status, lambda { |current_user, sender_id, status|
                           where(sender_id: current_user, reciever_id: sender_id, request_status: status)
                         }
  scope :follower_request, lambda { |current_user, reciever_id|
                             where(sender_id: current_user.id, reciever_id: reciever_id).first
                           }

  def self.request_status_change(current_user, reciver_id, status, follower)
    follower.update(sender_id: current_user, reciever_id: reciver_id, request_status: status)
  end
end
