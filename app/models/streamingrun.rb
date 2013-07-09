require 'active_resource'

class Streamingrun < ActiveResource::Base
  self.site = 'http://localhost:8000/'
  self.user = "quiltro"
  self.password = "perroCallejero"
  validates :streaming,  presence: true
end
