class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @webhook = Webhook.find_by!(token: params[:token])
    @webhook.run(payload: request.raw_post)
    head :no_content
  end
end
