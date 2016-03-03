class Webhook < ApplicationRecord
  FROM = %w(github esa)
  TO = %w(slack)

  validates :from, inclusion: { in: FROM }
  validates :to, inclusion: { in: TO }
  validates :token, uniqueness: true

  def run(payload:)
    comment = from_class.new(payload).parse
    mentions = [] # TODO: mappingしてから次へ
    to_class.new(mentions).run
  end

  def from_class
    Webhooks::From.const_get(from.classify)
  end

  def to_class
    Webhooks::To.const_get(to.classify)
  end
end
