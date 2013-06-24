require 'active_resource'

class Tweet < ActiveResource::Base
  self.site = 'http://localhost:8000/'
  validates :created_at,  presence: true, length: { maximum: 100 }
  validates :text, presence: true, length: { maximum: 140 }
end
