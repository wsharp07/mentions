class Webhooks::From::Base
  PATTERNS = %w()

  attr_reader :payload

  def initialize(payload:)
    @payload = JSON.parse(payload)
  rescue
    @payload = {}
  end

  def comment
    ''
  end

  def url
    ''
  end

  def mentions
    comment.match(/@([\S]+)/).to_a[1..-1] || []
  end

  def additional_message
    "you've been mentioned"
  end

  private

  def search_content(*keys)
    self.class::PATTERNS.map { |pattern| @payload.dig(*[pattern, *keys]) }.compact.first
  end
end
