class Book < ApplicationRecord
  include Stardust::Hooks::Hook::Publishable

  has_many :book_audits

  private

  def hook_scope
    self
  end

  def publishable_attributes
    super - publishable_attributes_to_ignore
  end

  def publishable_attributes_to_ignore
    [:updated_at].freeze
  end
end
