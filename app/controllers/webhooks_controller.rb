class WebhooksController < ApplicationController
  def create
    @webhook = Webhook.find_by!(token: params[:token])
    @webhook.run(payload: params[:body])
    head :no_content
  end
end
