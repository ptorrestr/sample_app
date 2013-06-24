class TweetsController < ApplicationController
  before_action :correct_search, only: :index

  def index
    @tweets = @search.tweets
  end

  private
    def correct_search
      @search = current_user.searches.find_by(id: params[:search])
      puts params[:search]
      redirect_to root_url if @search.nil?
    end
end
