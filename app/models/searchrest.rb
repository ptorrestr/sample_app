require 'active_resource'

class Searchrest < ActiveResource::Base
  self.site = 'http://localhost:8000/'
end
