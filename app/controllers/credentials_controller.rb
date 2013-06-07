class CredentialsController < ApplicationController
  before_action :signed_in_user, only: [:index, :create, :destroy]
  before_action :correct_user, only: :destroy

  def index
    @credential = current_user.credentials.build
    @credentials = current_user.credentials.paginate(page: params[:page])
  end

  def create
    @credential = current_user.credentials.build(credential_params)
    if @credential.save
      flash[:success] = "Credential created!"
      redirect_to credentials_path
    else
      @credentials = current_user.credentials.paginate(page: params[:page])
      render 'index'
    end
  end

  def destroy
    @credential.destroy
    flash[:success] = "Credential destroyed."
    redirect_to credentials_path
  end

  private
    def credential_params
      params.require(:credential).permit(:consumer, :consumer_secret, :access,
                                        :access_secret, :name)
    end

    def signed_in_user
      store_location
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end

    def correct_user
      @credential = current_user.credentials.find_by(id: params[:id])
      redirect_to credentials_path if @credential.nil?
    end

end
