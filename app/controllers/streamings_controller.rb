class StreamingsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :index]
  before_action :correct_user, only: [:destroy]

  def index
    @streaming = current_user.streamings.build
    @streamings = current_user.streamings.paginate(page: params[:page])
  end

  def create
    @streaming = current_user.streamings.build(streaming_params)
    if @streaming.save
      @streamingrest = fill_streamingrest(@streaming)
      if @streamingrest.save
        flash[:success] = "Streaming created!"
        redirect_to streamings_path
      else
        @streaming.destroy
        #is this line correct? original: @feed_items = []
        @feed_items = current_user.feed.paginate(page: params[:page])
        render 'index'
      end
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'index'
    end
  end

  def destroy
    @streaming.destroy
    @streamingrest = find_streamingrest(@streaming.id)
    if not @streamingrest.blank?
      @streamingrest.destroy
    end
    redirect_to streamings_path
  end

  private
    def streaming_params
      params.require(:streaming).permit(:query, :credential_id)
    end

    def correct_user
      @streaming = current_user.streamings.find_by(id: params[:id])
      redirect_to streamings_path if @streaming.nil?
    end

    def fill_streamingrest(streaming)
      if not streaming.credential.blank?
        streamingrest = Streamingrest.build()
        streamingrest.id = streaming.id
        streamingrest.query = streaming.query
        streamingrest.consumer = streaming.credential.consumer
        streamingrest.consumer_secret = streaming.credential.consumer_secret
        streamingrest.access = streaming.credential.access
        streamingrest.access_secret = streaming.credential.access_secret
        return streamingrest
      else
        return false
      end
    end

    def find_streamingrest(id)
      if Streamingrest.exists?(id)
        return Streamingrest.find(id)
      end
    end
end
