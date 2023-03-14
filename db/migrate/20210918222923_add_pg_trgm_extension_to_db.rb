# frozen_string_literal: true

class AddPgTrgmExtensionToDb < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :firstname
  end
end
