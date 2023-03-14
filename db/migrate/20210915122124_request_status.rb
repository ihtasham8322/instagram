# frozen_string_literal: true

class RequestStatus < ActiveRecord::Migration[5.2]
  def change
    add_column :followers, :request_status, :string, default: 'no_request'
  end
end
