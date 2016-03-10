require 'test_helper'

class WebhooksControllerTest < ActionDispatch::IntegrationTest
  def test_hook_with_wrong_token
    assert_raises(ActiveRecord::RecordNotFound) do
      post '/webhooks/undefined'
    end
  end

  def test_hook_from_github
    %w(commit_comment
       issue_comment
       pull_request
       issues
       pull_request_review_comment).each do |event|

      webhook = webhooks(:github_to_slack)
      payload = YAML.load_file("#{Rails.root}/test/payloads/github_payloads.yml")[event]['body']

      post "/webhooks/#{webhook.token}", params: payload
      assert_response :success
    end
  end
end
