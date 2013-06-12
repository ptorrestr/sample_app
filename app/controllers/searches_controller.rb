class SearchesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @search = current_user.searches.build(search_params)
    if @search.save
      @searchrest = fill_searchrest(@search)
      if @searchrest.save
        @search.searchrest_id = @searchrest.id
        @search.save
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
    @searchrest = find_searchrest(@search.searchrest_id)
    if not @searchrest.blank?
      @searchrest.destroy
    end
    redirect_to root_url
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
        searchrest.query = search.query
        searchrest.consumer = search.credential.consumer
        searchrest.consumer_secret = search.credential.consumer_secret
        searchrest.access = search.credential.access
        searchrest.access_secret = search.credential.access_secret
        searchrest.search_id = search.id
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
