class Webhooks::From::Github
  attr_reader :payload

  def initialize(payload)
    @payload = JSON.parse(payload)
  end

  def parse
    comment_body
  end

  def comment_body
    # 雑に探す
    @payload['pull_request']['body']
  rescue
    @payload['comment']['body']
  end
end
