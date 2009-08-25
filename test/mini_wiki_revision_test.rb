require File.dirname(__FILE__) + '/test_helper.rb'

class MiniWikiRevisionTest < Test::Unit::TestCase
  load_schema
  
  def test_mini_wiki_revision
    assert_kind_of MiniWikiRevision, MiniWikiRevision.new 
  end
end