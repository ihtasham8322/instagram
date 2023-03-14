# frozen_string_literal: true

module LikeHelper
  def post_like?(post_id)
    Like.where(post_id: post_id, user_id: current_user.id).any?
  end

  def like_id(post_id)
    Like.find_by(post_id: post_id, user_id: current_user.id).id
  end
end
