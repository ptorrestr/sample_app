require 'active_resource'

class Twitteruser < ActiveResource::Base
  self.site = 'http://localhost:8000/'
  self.element_name = "user"
  validates :created_at,  presence: true, length: { maximum: 200 }
  validates :name, presence: true, length: { maximum: 200 }
end
