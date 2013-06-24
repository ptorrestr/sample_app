require 'active_resource'

class Tweetsearch < ActiveResource::Base
  self.site = 'http://localhost:8000/'
end
