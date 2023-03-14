# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    Follower.request_status(user.id, @record.user_id, 'accepted').any? ||
      user.id == @record.user_id || User.find_by(id: @record.user_id).public?
  end

  def update?
    self?
  end

  def destroy?
    self?
  end

  def edit?
    self?
  end

  def self?
    @user.id == @record.post.user_id
  end
end
