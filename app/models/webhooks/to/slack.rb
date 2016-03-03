class Webhooks::To::Slack
  def webhook_url
    ENV['SLACK_WEBHOOK_URL']
  end

  def run
  end
end
