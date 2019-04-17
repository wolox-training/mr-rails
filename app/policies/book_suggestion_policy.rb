class BookSuggestionPolicy < ApplicationPolicy
  def create?
    user.id == record.user_id || record.user_id.blank?
  end
end
