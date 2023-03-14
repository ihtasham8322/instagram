# frozen_string_literal: true

class AddDefaultValueToPostLike < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :likes, :integer, default: 0
  end
end
