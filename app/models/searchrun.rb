require 'active_resource'

class Searchrun < ActiveResource::Base
  self.site = 'http://localhost:8000/'
  self.user = "quiltro"
  self.password = "perroCallejero"
  validates :search,  presence: true
end
