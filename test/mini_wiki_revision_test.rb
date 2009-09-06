require 'test_helper.rb'

class MiniWikiRevisionTest < ActiveSupport::TestCase
  # TODO: test models
  
  def test_mini_wiki_revision
    assert_kind_of MiniWikiRevision, MiniWikiRevision.new 
  end
  
  def test_mini_wiki_revision_size
    assert_equal 5, MiniWikiRevision.count
  end
end