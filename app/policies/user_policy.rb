# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    self?
  end

  def edit?
    self?
  end

  def update?
    self?
  end

  def show?
    Follower.request_status(user.id, @record.id, 'accepted').any? ||
      user.id == @record.id || User.find_by(id: @record.id).public?
  end

  def self?
    @user.id == @record.id
  end
end
