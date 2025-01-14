# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  # Initialize the policy with the current user and the record being accessed
  def initialize(user, record)
    @user = user
    @record = record
  end

  # Default policy for index action, deny access
  def index?
    false
  end

  # Default policy for show action, deny access
  def show?
    false
  end

  # Default policy for create action, deny access
  def create?
    false
  end

  # Alias new action to create action
  def new?
    create?
  end

  # Default policy for update action, deny access
  def update?
    false
  end

  # Alias edit action to update action
  def edit?
    update?
  end

  # Default policy for destroy action, deny access
  def destroy?
    false
  end

  # Scope class to define the scope of accessible records
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    # Method to resolve the scope, must be implemented in subclasses
    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
