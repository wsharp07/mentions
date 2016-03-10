class Webhooks::To::Slack
  attr_reader :from_instance

  def initialize(mentions:, url:, additional_message:)
    @mentions = mentions
    @url = url
    @additional_message = additional_message
  end

  def webhook_url(mention)
    "#{ENV['SLACK_WEBHOOK_URL']}&channel=@#{mention}"
  end

  def run
    @mentions.each do |mention|
      post(webhook_url(mention), "@#{mention} #{@url} #{@additional_message}")
    end
  end

  def post(webhook, payload)
    Net::HTTP.post_form(URI.parse(webhook), { payload: payload })
  end
end
