# frozen_string_literal: true

class AddindexOnReciverSender < ActiveRecord::Migration[5.2]
  def change
    add_index :followers, :sender_id
    add_index :followers, :reciever_id
  end
end
