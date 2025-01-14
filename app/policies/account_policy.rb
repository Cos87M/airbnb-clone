class AccountPolicy < ApplicationPolicy

  # Check if the user is allowed to view the account
  def show?
    user == record
  end

  # Check if the user is allowed to update the account
  def update?
    user == record
  end
end
