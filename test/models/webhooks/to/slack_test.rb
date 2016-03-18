require 'test_helper'

class Webhooks::To::SlackTest < ActiveSupport::TestCase
  def test_run
    mention = 'ppworks'
    url = 'http://example.com'
    additional_message = 'message'
    Net::HTTP.expects(:post_form)

    slack = Webhooks::To::Slack.new(mention: mention, url: url, additional_message: additional_message)
    slack.post

    assert_equal "@#{mention}", slack.instance_variable_get(:@channel)
  end

  def test_run_all
    mention = 'all'
    url = 'http://example.com'
    additional_message = 'message'
    Net::HTTP.expects(:post_form)

    slack = Webhooks::To::Slack.new(mention: mention, url: url, additional_message: additional_message)
    slack.post

    assert_equal '#general', slack.instance_variable_get(:@channel)
  end
end
