# frozen_string_literal: true

class AddFollowerforiginkey < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :followers, :users, column: :sender_id
    add_foreign_key :followers, :users, column: :reciever_id
  end
end
