require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'mocha/mini_test'

ENV['RAILS_ENV'] ||= 'test'
ENV['MENTIONS_MAPPING_FILE_PATH'] = "#{Rails.root}/test/files/mention_mappings.yml"
ENV['SLACK_WEBHOOK_URL'] = 'http://example.com/slack'

Dir[Rails.root.join('test/support/**/*.rb')].each { |f| require f }
