require 'test_helper.rb'

class MiniWikiTest < ActiveSupport::TestCase
  
  class MiniWikiPage < ActiveRecord::Base
  end

  class MiniWikiRevision < ActiveRecord::Base
  end

  def test_schema_has_loaded_correctly
    assert_equal 2, MiniWikiPage.count
    assert_equal 5, MiniWikiRevision.count
  end 
end
