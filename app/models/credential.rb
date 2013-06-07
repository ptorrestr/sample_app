class Credential < ActiveRecord::Base
  belongs_to :user
  has_many :search, dependent: :destroy
  before_validation :create_name_user_token
  default_scope -> { order('created_at DESC') }
  validates :consumer, presence: true
  validates :consumer_secret, presence: true
  validates :access, presence: true
  validates :access_secret, presence: true
  validates :user_id, presence: true
  validates :name, presence: true
  validates :name_user, presence: true, uniqueness: { case_sensitive: false }

  private
    def create_name_user_token
      self.name_user ||= "#{self.name} #{self.user_id}"
    end
end
