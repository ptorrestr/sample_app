require 'active_resource'

class Search < ActiveRecord::Base
  belongs_to :user
  belongs_to :credential
  default_scope -> { order('created_at DESC') }
  validates :query, presence: true, length: { maximum:140 }
  validates :credential_id, presence: true
  validates :user_id, presence: true

  def tweets
    @collection = []
    #This method only retreive the last ten tweets
    Tweetsearch.find(:all, :params => {:search_id => id }).each do |tweetsearch|
        @collection << Tweet.find(tweetsearch.tweet)
    end
    return @collection
  end

  def all_tweets
    #Get all tweets for this collection
    @collection = Tweet.find(:all, :params => {:search_id => id })
  end

  def get_searchrun
    Searchrun.find(:first, :params => {:search => id })
  end
end
