require 'test_helper'

class Webhooks::To::SlackTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  def test_run
    mention = 'ppworks'
    url = 'http://example.com'
    additional_message = 'message'

    slack = Webhooks::To::Slack.new(mention: mention, url: url, additional_message: additional_message)
    assert_enqueued_with(job: HttpPostJob) do
      slack.post
    end

    assert_equal "@#{mention}", slack.instance_variable_get(:@channel)
    assert_enqueued_jobs 1
  end

  def test_run_everyone
    mention = 'everyone'
    url = 'http://example.com'
    additional_message = 'message'

    slack = Webhooks::To::Slack.new(mention: mention, url: url, additional_message: additional_message)
    assert_enqueued_with(job: HttpPostJob) do
      slack.post
    end

    assert_equal '#general', slack.instance_variable_get(:@channel)
    assert_enqueued_jobs 1
  end
end
