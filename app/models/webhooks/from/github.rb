class Webhooks::From::Github
  PATTERNS = %w(comment pull_request issue)
  attr_reader :payload

  def initialize(payload:)
    @payload = payload
  rescue
    @payload = {}
  end

  def comment
    assigned? ? 'assigned' : search_content('body')
  end

  def url
    search_content('html_url')
  end

  def mentions
    if assigned?
      [search_content('assignee')].compact
    else
      comment.match(/@([\S]+)/).to_a[1..-1] || []
    end
  end

  def assigned?
    @payload.dig('action') == 'assigned'
  end

  private

  def search_content(key)
    PATTERNS.map { |pattern| @payload.dig(pattern, key) }.compact.first
  end
end
