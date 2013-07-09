require 'csv'

class TweetsController < ApplicationController
  before_action :correct_search, only: :index

  def index
    @tweets = @collection.tweets
    
    respond_to do |format|
      format.html
      format.csv { send_data get_csv,
                    :type => 'text/csv; charset=iso-8859-1; header=present', 
                    :disposition => "attachment; filename=tweets.csv" }
    end
  end

  private
    def correct_search
      @kind = params[:kind]
      if @kind == "search"
        # Search in searches for collection
        @valid_search = true
        @collection = current_user.searches.find_by(id: params[:search])
        if @collection.nil?
          redirect_to searches_path
        end
        return
      else
        # Search in streaming for collection
        @valid_streaming = true
        @collection = current_user.streamings.find_by(id: params[:streaming])
        redirect_to streamings_path if @collection.nil?
      end
    end

    def get_csv
      CSV.generate do |csv|
        @collection.all_tweets.each do |tweet|
          csv << [tweet.id, 
                tweet.created_at, 
                tweet.favorited, 
                tweet.text,
                tweet.in_reply_to_screen_name,
                tweet.in_reply_to_user_id,
                tweet.in_reply_to_status_id,
                tweet.truncated,
                tweet.source,
                tweet.urls,
                tweet.user_mentions,
                tweet.hashtags,
                tweet.geo,
                tweet.place,
                tweet.coordinates,
                tweet.contributors,
                tweet.retweeted,
                tweet.retweet_count]
        end
      end    
    end
end
