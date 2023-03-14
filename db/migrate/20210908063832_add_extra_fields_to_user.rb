# frozen_string_literal: true

class AddExtraFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    change_table :users, bulk: true do |t|
      t.string :firstname, null: false
      t.string :lastname, null: false
    end
  end
end
