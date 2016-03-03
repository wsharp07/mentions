require 'test_helper'

class IdMappingTest < ActiveSupport::TestCase
  def test_convert_with_local_file
    file_path = "#{Rails.root}/test/files/mention_mappings.yml"
    mapping = IdMapping.new(file_path)
    assert_equal 'ppworks', mapping.find(user_name: 'koshikawa_naoto', from: 'esa', to: 'slack')
  end

  def test_convert_with_gist
    file_path = "https://***REMOVED***/mention_mappings.yml"
    mapping = IdMapping.new(file_path)
    assert_equal 'ppworks', mapping.find(user_name: 'koshikawa_naoto', from: 'esa', to: 'slack')
  end
end
