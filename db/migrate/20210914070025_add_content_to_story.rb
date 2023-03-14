# frozen_string_literal: true

class AddContentToStory < ActiveRecord::Migration[5.2]
  def change
    add_column :stories, :content, :string, null: false
  end
end
