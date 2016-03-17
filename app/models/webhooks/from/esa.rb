class Webhooks::From::Esa
  PATTERNS = %w(comment post)
  attr_reader :payload

  def initialize(payload:)
    @payload = JSON.parse(payload)
  rescue
    @payload = {}
  end

  def comment
    search_content('body_md')
  end

  def url
    @payload.dig('post', 'url')
  end

  def mentions
    return [] unless @payload.dig('kind') =~ /_mention\z/
    comment.match(/@([\S]+)/).to_a[1..-1] || []
  end

  def additional_message
    "you've been mentioned(\\( ⁰⊖⁰)/)"
  end

  private

  def search_content(*keys)
    PATTERNS.map { |pattern| @payload.dig(*[pattern, *keys]) }.compact.first
  end
end
