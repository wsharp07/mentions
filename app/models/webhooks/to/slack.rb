class Webhooks::To::Slack
  attr_reader :mentions

  def initialize(mentions)
    @mentions = mentions
  end

  def webhook_url
    ENV['SLACK_WEBHOOK_URL']
  end

  def run
  end
end
