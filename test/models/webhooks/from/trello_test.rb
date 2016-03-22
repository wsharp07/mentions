require 'test_helper'

class Webhooks::From::TrelloTest < ActiveSupport::TestCase
  def test_comment
    %w(comment_card).each do |event|

      payload = YAML.load_file("#{Rails.root}/test/payloads/trello_payloads.yml")[event]['body']
      trello = Webhooks::From::Trello.new(payload: payload)

      assert_equal "#{event} body", trello.comment
      assert_match /lEZ5xRyJ\z/, trello.url
    end
  end
end
