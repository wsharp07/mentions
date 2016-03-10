require 'test_helper'

class IdMappingTest < ActiveSupport::TestCase
  def test_convert_with_local_file
    file_path = "#{Rails.root}/test/files/mention_mappings.yml"
    mapping = IdMapping.new(file_path)
    assert_equal 'ppworks', mapping.find(user_name: 'koshikawa_naoto', from: 'esa', to: 'slack')
  end

  def test_convert_with_gist
    file_path = "https://gist.githubusercontent.com/ppworks/49f6ce44efb09d5fc8e9/raw/c1465aab5d6604b98ba6ca4c31263a5b36f62378/mention_mappings.ym://gist.githubusercontent.com/ppworks/49f6ce44efb09d5fc8e9/raw/c1465aab5d6604b98ba6ca4c31263a5b36f62378/mention_mappings.yml"
    mapping = IdMapping.new(file_path)
    assert_equal 'ppworks', mapping.find(user_name: 'koshikawa_naoto', from: 'esa', to: 'slack')
  end
end
