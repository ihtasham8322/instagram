# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    self?
  end

  def update?
    self?
  end

  def edit?
    self?
  end

  def destroy?
    self?
  end

  def self?
    @user.id == @record.user_id
  end
end
