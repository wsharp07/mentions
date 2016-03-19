require 'test_helper'

class Webhooks::From::BitbucketTest < ActiveSupport::TestCase
  def test_comment
    %w(issue_create
       issue_comment
       pullrequest_create
       pullrequest_comment).each do |event|

      payload = YAML.load_file("#{Rails.root}/test/payloads/bitbucket_payloads.yml")[event]['body']
      bitbucket = Webhooks::From::Bitbucket.new(payload: payload)

      assert_equal "#{event} body", bitbucket.comment
    end
  end
end
