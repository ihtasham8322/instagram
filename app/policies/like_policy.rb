# frozen_string_literal: true

class LikePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    self?
  end

  def destroy?
    self?
  end

  def self?
    Follower.request_status(user.id, @record.user_id, 'accepted').any? ||
      user.id == @record.user_id || User.find_by(id: @record.user_id).public?
  end
end
