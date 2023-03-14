# frozen_string_literal: true

module UserHelper
  def request_status(user_id)
    if current_user.connections_sent.exists?(reciever_id: user_id)
      User.request_status_check(current_user, user_id).request_status
    else
      'no request'
    end
  end
end
