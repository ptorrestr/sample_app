class SearchrunsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: [:create]

  def create
    @searchrun = Searchrun.new(searchrun_params)
    #@search.save
    if @searchrun.save
      flash[:success] = "Starting search!"
      redirect_to searches_path
    else
      render 'index'
    end
  end

  def destroy
    @searchrun = find_searchrun(params[:id])
    @searchrun.destroy
    flash[:success] = "search stoped"
    redirect_to searches_path
  end

  private
    def correct_user
      @search = current_user.searches.find_by(id: params[:search])
      redirect_to searches_path if @search.nil?
    end

    def searchrun_params
      params.permit(:search)
    end

    def find_searchrest(id)
      if Searchrest.exists?(id)
        return Searchrest.find(id)
      end
    end

    def find_searchrun(id)
      Searchrun.find(id)
    end
end
