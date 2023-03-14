# frozen_string_literal: true

module UpdateRequest
  extend ActiveSupport::Concern

  def follow_check(reciever_id)
    current_user.connections_sent.exists?(reciever_id: reciever_id)
  end

  def update_request(reciever_id)
    follower = Follower.follower_request(current_user, reciever_id)
    update_request_status(follower, reciever_id)
  end

  def check_account_status(reciever_id)
    User.find(reciever_id).public
  end

  def update_request_status(follower, reciever_id)
    case follower.request_status
    when 'pending', 'accepted'
      Follower.request_status_change(current_user.id, reciever_id, 'unfollow', follower)
    else
      public_privete_request(follower, reciever_id)
    end
  end

  def public_privete_request(follower, reciever_id)
    if check_account_status(reciever_id)
      Follower.request_status_change(current_user.id, reciever_id, 'accepted', follower)
    else
      Follower.request_status_change(current_user.id, reciever_id, 'pending', follower)
    end
  end
end
