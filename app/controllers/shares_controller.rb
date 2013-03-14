class SharesController < ApplicationController
  before_filter :restrict_access

  # respond_to :json

  layout :false

  def index
    render json: Share.order('created_at DESC').all
  end

  def show
    render json: Share.find(params[:id])
  end

  def create
    # note: always render/return a json response, even for errors
puts "request=#{request.inspect}"
    api_key = params[:api_key]
    if api_key.blank?
      render json: {errors: ["API key is invalid."]}, status: 422
      return
    end
    host = params[:host]
    if host.blank?
      render json: {errors: ["Parameter host is missing."]}, status: 422
      return
    end
    email = params[:email]
    if email.blank?
      render json: {errors: ["Parameter email is missing."]}, status: 422
      return
    end
    share_type = params[:share][:share_type]
    if share_type.blank?
      render json: {errors: ["Parameter share_type is missing."]}, status: 422
      return
    end
    # share = Share.new(share_type: share_type)
    # share.share_as_json = params[:share]
    share = Share.new(params[:share])
    share.save(validate: false)
    sharing = JSON.parse(share.share_as_json)
    # puts "sharing(#{sharing.class})=#{sharing.to_yaml}"
    # render json: share.id
    render json: share
  end

  def update
    render json: {errors: ["Shares may not be updated."]}, status: 422
  end

  def destroy
    # respond_with Share.destroy(params[:id])
    render text: params
  end

  private

  # def restrict_access
  #   api_key = ApiKey.find_by_access_token(params[:access_token])
  #   head :unauthorized unless api_key
  # end

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
puts "token=#{token.inspect}\n options=#{options.inspect}"
      # ApiKey.exists?(access_token: token)
      true
    end
  end
end
