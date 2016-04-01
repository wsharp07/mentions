class Webhooks::From::Trello < Webhooks::From::Base
  PATTERNS = %w()

  def comment
    @payload.dig('action', 'data', 'text')
  end

  def url
    "https://trello.com/c/#{@payload.dig('action', 'data', 'card', 'shortLink')}"
  end

  def accept?
    @payload.dig('action', 'type') == 'commentCard'
  end
end
