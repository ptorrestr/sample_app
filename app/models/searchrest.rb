require 'active_resource'

class Searchrest < ActiveResource::Base
  self.site = 'http://localhost:8000/'
  self.element_name = "search"
  validates :query,  presence: true, length: { maximum: 140 }
  validates :consumer,  presence: true, length: { maximum: 100 }
  validates :consumer_secret,  presence: true, length: { maximum: 100 }
  validates :access,  presence: true, length: { maximum: 100 }
  validates :access_secret,  presence: true, length: { maximum: 100 }  
end
