class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :log_raw_post
  before_action :set_webhook

  def create
    @webhook.run(payload: request.raw_post)
    head :no_content
  end

  def show
    head :ok
  end

  private

  def log_raw_post
    logger.info(request.raw_post)
  end

  def set_webhook
    @webhook = Webhook.new_by_token(params[:token]) || Webhook.find_by!(token: params[:token])
  end
end
