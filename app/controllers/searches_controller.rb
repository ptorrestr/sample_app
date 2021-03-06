class SearchesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :index]
  before_action :correct_user, only: [:destroy]

  def index
    @search = current_user.searches.build
    @searches = current_user.searches.paginate(page: params[:page])
  end

  def create
    @search = current_user.searches.build(search_params)
    if @search.save
      @searchrest = fill_searchrest(@search)
      if @searchrest.save
        flash[:success] = "Search created!"
        redirect_to searches_path
      else
        @search.destroy
        #is this line correct? original: @feed_items = []
        @searches = current_user.searches.paginate(page: params[:page])
        render 'index'
      end
    else
      @searches = current_user.searches.paginate(page: params[:page])
      render 'index'
    end
  end

  def destroy
    @search.destroy
    @searchrest = find_searchrest(@search.id)
    if not @searchrest.blank?
      @searchrest.destroy
    end
    redirect_to searches_path
  end

  private
    def search_params
      params.require(:search).permit(:query, :credential_id, :kind)
    end

    def correct_user
      @search = current_user.searches.find_by(id: params[:id])
      redirect_to searches_path if @search.nil?
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
