class StreamingrunsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: [:create]

  def create
    @streamingrun = Streamingrun.new(streamingrun_params)
    #@streaming.save
    if @streamingrun.save
      flash[:success] = "Starting streaming search!"
      redirect_to streamings_path
    else
      render 'index'
    end
  end

  def destroy
    @streamingrun = find_streamingrun(params[:id])
    @streamingrun.destroy
    flash[:success] = "streaming search stoped"
    redirect_to streamings_path
  end

  private
    def correct_user
      @streaming = current_user.streamings.find_by(id: params[:streaming])
      redirect_to streamings_path if @streaming.nil?
    end

    def streamingrun_params
      params.permit(:streaming)
    end

    def find_streamingrest(id)
      if Streamingrest.exists?(id)
        return Streamingrest.find(id)
      end
    end

    def find_streamingrun(id)
      Streamingrun.find(id)
    end
end
