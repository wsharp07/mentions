require 'test_helper'

class WebhookTest < ActiveSupport::TestCase
  def test_valid_webhook
    webhook = webhooks(:github_to_slack)
    assert webhook.valid?
  end

  def test_invalid_webhook
    webhook = webhooks(:github_to_idobata)
    assert !webhook.valid?
  end

  def test_from_class
    webhook = webhooks(:github_to_slack)
    assert_equal Webhooks::From::Github, webhook.from_class
  end

  def test_to_class
    webhook = webhooks(:github_to_slack)

    assert_equal Webhooks::To::Slack, webhook.to_class
  end

  def test_run
    slack = mock('Webhooks::To::Slack')
    Webhooks::To::Slack.expects(:new).returns(slack)
    slack.expects(:run)

    webhook = webhooks(:github_to_slack)
    webhook.run(payload: {comment: {body: '@ppworks 見てくだい'}}.to_json)
  end
end
