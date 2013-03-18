class ApiKeysController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @api_keys = ApiKey.order('updated_at DESC').page(params[:page]).per_page(12)
  end

  def show
    redirect_to api_keys_url
  end

  def new
    @api_key = ApiKey.new
    @api_key.generate_token
  end

  def create
    @api_key = ApiKey.new(params[:api_key])
    if @api_key.save
      redirect_to api_keys_url, :notice => "API Key was successfully created."
    else
      render action: "new"
    end
  end

  def edit
    redirect_to api_keys_url
  end

  def update
    redirect_to api_keys_url
  end

  def destroy
    @api_key = ApiKey.find(params[:id])
    @api_key.destroy
    redirect_to api_keys_url, notice: "API Key was deleted."
  end
end
