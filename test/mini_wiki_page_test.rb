require File.dirname(__FILE__) + '/test_helper.rb'

class MiniWikiPageTest < Test::Unit::TestCase
  load_schema
  
  def test_mini_wiki_page
    assert_kind_of MiniWikiPage, MiniWikiPage.new 
  end
end