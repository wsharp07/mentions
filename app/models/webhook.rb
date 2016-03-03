class Webhook < ApplicationRecord
  FROM = %w(github esa)
  TO = %w(slack)

  validates :from, inclusion: { in: FROM }
  validates :to, inclusion: { in: TO }
  validates :token, uniqueness: true

  def run
    from_class.new.run(to_class.new)
  end

  def from_class
    Webhooks::From.const_get(from.classify)
  end

  def to_class
    Webhooks::To.const_get(to.classify)
  end
end
