require 'test_helper'

class MiniWikiTest < Test::Unit::TestCase  #ActiveSupport::TestCase
  load_schema
  
  class MiniWikiPage < ActiveRecord::Base
  end

  class MiniWikiRevision < ActiveRecord::Base
  end

  def test_schema_has_loaded_correctly
    assert_equal [], MiniWikiPage.all
    assert_equal [], MiniWikiRevision.all
  end 
  
  # Replace this with your real tests.
  #test "the truth" do
  #  assert true
  #end
end
