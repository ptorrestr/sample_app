class Search < ActiveRecord::Base
  belongs_to :user
  belongs_to :credential
  default_scope -> { order('created_at DESC') }
  validates :query, presence: true, length: { maximum:140 }
  validates :credential_id, presence: true
  validates :user_id, presence: true
end
