ENV['RAILS_ENV'] ||= 'test'
ENV['MENTIONS_MAPPING_FILE_PATH'] = "#{Rails.root}/test/files/mention_mappings.yml"
ENV['SLACK_WEBHOOK_URL'] = 'http://example.com/slack'

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'mocha/mini_test'

class ActiveSupport::TestCase
  fixtures :all
end
