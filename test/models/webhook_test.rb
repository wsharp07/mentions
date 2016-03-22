require 'test_helper'

class WebhookTest < ActiveSupport::TestCase
  def test_valid_webhook
    webhook = webhooks(:github_to_slack)
    assert webhook.valid?
  end

  def test_invalid_webhook
    webhook = webhooks(:github_to_chatwork)
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
    Webhooks::To::Slack.any_instance.expects(:post)

    webhook = webhooks(:github_to_slack)
    webhook.run(payload: {'comment' => { 'html_url' => 'http://example.com/issue/1#issuecomment-1', 'body' => '@ppworks 見てください'}}.to_json)
  end

  def test_run_lack_of_slack
    Webhooks::To::Slack.any_instance.expects(:post).never

    webhook = webhooks(:github_to_slack)
    webhook.run(payload: {'comment' => { 'html_url' => 'http://example.com/issue/1#issuecomment-1', 'body' => '@taea 見てください'}}.to_json)
  end

  def test_run_lack_of_github
    Webhooks::To::Slack.any_instance.expects(:post).never

    webhook = webhooks(:github_to_slack)
    webhook.run(payload: {'comment' => { 'html_url' => 'http://example.com/issue/1#issuecomment-1', 'body' => '@fukayatsu 見てください'}}.to_json)
  end

  def test_new_by_env
    Webhook::FROM.each do |from|
      Webhook::TO.each do |to|
        token = SecureRandom.uuid
        env_key = "#{from.upcase}_TO_#{to.upcase}_TOKEN"
        ENV[env_key] = token

        webhook = Webhook.new_by_token(token)
        assert_equal to, webhook.to
        assert_equal from, webhook.from
        assert_equal token, webhook.token

        ENV.delete(env_key)
      end
    end
  end
end
