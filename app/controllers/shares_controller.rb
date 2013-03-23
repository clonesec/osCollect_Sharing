class SharesController < ApplicationController
  before_filter :restrict_access, except: [:list]

  layout :false

  def list
    @shares = Share.order('created_at DESC').page(params[:page]).per_page(12)
    render layout: 'application'
  end

  def index
    render json: Share.order('created_at DESC').all
  end

  def show
    share = Share.where(share_token: params[:id]).first
    render json: share
  end

  def create
    # note: always render/return a json response, even for errors
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
      render json: {errors: ["Parameter email is missing."]}, status: :unprocessable_entity # 422
      return
    end
    share_type = params[:share][:share_type]
    if share_type.blank?
      render json: {errors: ["Parameter share_type is missing."]}, status: 422
      return
    end
    share = Share.new(params[:share])
    share.share_origin = params[:host]
    share.email = email
    share.description = params[:description]
    share.save(validate: false)
    render json: {token: share.share_token}
  end

  def update
    render json: {errors: ["Shares may not be updated."]}, status: 422
  end

  def destroy
    share = Share.where(share_token: params[:id]).first
    if share
      share.destroy
      render json: {deleted: params[:id]}
    else
      render json: {errors: 'share not found.'}, status: 422
    end
  end
end
