# frozen_string_literal: true

class FollowerController < ApplicationController
  include UpdateRequest
  def update
    follower = Follower.follower_request(current_user, params[:sender_id])
    flash[:notice] =
      follower.update(request_status: 'accepted') ? 'You accepted request' : follower.errors.full_messages.to_sentence
    redirect_to post_index_path
  end

  def send_request
    if follow_check(params[:user_id])
      update_request(params[:user_id])
    else
      @follower = Follower.create!(sender_id: current_user.id, reciever_id: params[:user_id],
                                   request_status: user_status)
    end
    redirect_to search_path
  end

  private

  def user_status
    check_account_status(params[:user_id]) ? 'accepted' : 'pending'
  end
end
