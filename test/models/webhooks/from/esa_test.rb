require 'test_helper'

class Webhooks::From::EsaTest < ActiveSupport::TestCase
  def test_mention
    %w(post_mention
       comment_mention).each do |event|

      payload = YAML.load_file("#{Rails.root}/test/payloads/esa_payloads.yml")[event]['body']
      esa = Webhooks::From::Esa.new(payload: payload)

      assert_match /\Ahttp:\/\//, esa.url
      assert_match "#{event} body", esa.comment
      assert_equal ['koshikawa_naoto'], esa.mentions
    end
  end
end
