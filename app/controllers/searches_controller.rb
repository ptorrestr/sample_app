class SearchesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :index]
  before_action :correct_user, only: [:destroy, :index]

  def create
    @search = current_user.searches.build(search_params)
    if @search.save
      @searchrest = fill_searchrest(@search)
      if @searchrest.save
        flash[:success] = "Search created!"
        redirect_to root_url
      else
        @search.destroy
        @feed_items = []
        render 'static_pages/home'
      end
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @search.destroy
    @searchrest = find_searchrest(@search.id)
    if not @searchrest.blank?
      @searchrest.destroy
    end
    redirect_to root_url
  end

  def index
    @tweets = @search.all_tweets
    csv_string = CSV.generate do |csv|
      @tweets.each do |tweet|
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
    # send it to the browsah
    send_data csv_string, 
                :type => 'text/csv; charset=iso-8859-1; header=present', 
                :disposition => "attachment; filename=tweets.csv"   
  end

  private
    def search_params
      params.require(:search).permit(:query, :credential_id)
    end

    def correct_user
      @search = current_user.searches.find_by(id: params[:id])
      redirect_to root_url if @search.nil?
    end

    def fill_searchrest(search)
      if not search.credential.blank?
        searchrest = Searchrest.build()
        searchrest.id = search.id
        searchrest.query = search.query
        searchrest.consumer = search.credential.consumer
        searchrest.consumer_secret = search.credential.consumer_secret
        searchrest.access = search.credential.access
        searchrest.access_secret = search.credential.access_secret
        return searchrest
      else
        return false
      end
    end

    def find_searchrest(id)
      if Searchrest.exists?(id)
        return Searchrest.find(id)
      end
    end
end
