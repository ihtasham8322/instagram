# frozen_string_literal: true

class StoryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    self?
  end

  def show?
    Follower.request_status(user.id, @record.first.user_id, 'accepted').any? ||
      user.id == @record.first.user_id || User.find_by(id: @record.first.user_id).public?
  end

  def destroy?
    self?
  end

  def self?
    @user.id == @record.user_id
  end
end
