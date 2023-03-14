# frozen_string_literal: true

class AddAccountStatus < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :public, :boolean, default: true
  end
end
