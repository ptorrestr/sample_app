require 'active_resource'

class Tweet < ActiveResource::Base
  self.site = 'http://localhost:8000/'
  self.user = "quiltro"
  self.password = "perroCallejero"
  validates :created_at,  presence: true, length: { maximum: 100 }
  validates :text, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  def twitteruser
    Twitteruser.find(user_id)
  end
end
