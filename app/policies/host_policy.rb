class HostPolicy < ApplicationPolicy
  # Check if the user is allowed to access the index action
  def index?
    user.host?
  end

  # Check if the user is allowed to access the new action
  def new?
    user.host?
  end

  # Check if the user is allowed to access the show action
  def show?
    user.host?
  end

  # Check if the user is allowed to access the create action
  def create?
    user.host?
  end

  # Check if the user is allowed to access the update action
  def update?
    user.host?
  end

  # Check if the user is allowed to access the destroy action
  def destroy
    user.host?
  end
end
