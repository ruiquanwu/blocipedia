class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    record.user == user || !record.private || user.admin?
  end
end