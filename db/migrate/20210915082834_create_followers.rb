# frozen_string_literal: true

class CreateFollowers < ActiveRecord::Migration[5.2]
  def change
    create_table :followers do |t|
      t.bigint :sender_id
      t.bigint :reciever_id

      t.timestamps
    end
  end
end
