require File.dirname(__FILE__) + '/test_helper.rb'

class MiniWikiPageTest < ActiveSupport::TestCase
  # TODO: test models
  
  def test_mini_wiki_page
    assert_kind_of MiniWikiPage, MiniWikiPage.new 
  end
  
  def test_mini_wiki_page_size
    assert_equal 2, MiniWikiPage.count
  end
end