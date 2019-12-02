class Book < ApplicationRecord
  include Stardust::Hooks::Hook::Publishable

  has_many :book_audits, dependent: :destroy
  belongs_to :account

  def audit_stamp
    "#{title} - #{author} - STAMPED"
  end

  private

  def hook_scope
    self.account
  end

  def publishable_attributes
    super - publishable_attributes_to_ignore
  end

  def publishable_attributes_to_ignore
    [:updated_at].freeze
  end
end
