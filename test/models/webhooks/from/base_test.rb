require 'test_helper'

class Webhooks::From::BaseTest < ActiveSupport::TestCase
  def test_mentions
    base = Webhooks::From::Base.new(payload: '{}')

    base.stubs(:comment).returns('hello')
    assert_equal [], base.mentions

    base.stubs(:comment).returns('@ppworks @ppworks')
    assert_equal %w(ppworks), base.mentions

    base.stubs(:comment).returns('@ppworks @nalabjp')
    assert_equal %w(ppworks nalabjp), base.mentions
  end
end
