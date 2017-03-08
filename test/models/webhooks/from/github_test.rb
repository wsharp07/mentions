require 'test_helper'

class Webhooks::From::GithubTest < ActiveSupport::TestCase
  def test_comment
    %w(commit_comment
       issue_comment
       pull_request
       issues
       pull_request_review_comment).each do |event|

      payload = YAML.load_file("#{Rails.root}/test/payloads/github_payloads.yml")[event]['body']
      github = Webhooks::From::Github.new(payload: payload)

      assert github.accept?
      assert_equal "#{event} body", github.comment
    end
  end

  def test_assigned
    %w(assigned_issue
       assigned_pull_request).each do |event|

      payload = YAML.load_file("#{Rails.root}/test/payloads/github_payloads.yml")[event]['body']
      github = Webhooks::From::Github.new(payload: payload)

      assert github.accept?
      assert github.assigned?
      assert_equal 'assigned', github.comment
      assert_equal ['ppworks'], github.mentions
    end
  end

  def test_accept?
    %w(created
       opened
       assigned).each do |action|

      payload = { action: action }.to_json
      github = Webhooks::From::Github.new(payload: payload)

      assert github.accept?
    end
  end

  def test_does_not_accept?
    payload = { action: 'synchronize' }.to_json
    github = Webhooks::From::Github.new(payload: payload)

    assert !github.accept?
  end
end
