class Webhooks::To::Slack
  def initialize(mention:, url:, additional_message:)
    @mention = "@#{mention}"
    @channel = @mention == '@all' ? '#general' : @mention
    @text = "#{@mention} #{url} #{additional_message}"
    @webhook_uri = URI.parse(ENV.fetch('SLACK_WEBHOOK_URL'))
  end

  def post
    Net::HTTP.post_form(@webhook_uri, { payload: {text: @text, link_names: 1, channel: @channel}.to_json })
  end
end
