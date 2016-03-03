class Webhooks::From::Github
  attr_reader :payload

  def initialize(payload)
    @payload = JSON.parse(payload)
  rescue
    @payload = nil
  end

  def parse
    # 雑に探す
    @payload['pull_request']['body']
  rescue
    @payload['comment']['body']
  end
end
