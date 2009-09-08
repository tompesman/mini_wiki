require 'test_helper.rb'

include MiniWikiHelper
include ActionView::Helpers::UrlHelper
include ActionView::Helpers::TagHelper

# test helper using the ActionController::TestCase to test the link_to in the helper
class MiniWikiHelperTest < ActionController::TestCase
  tests MiniWikiController
  
  test "to wiki nil" do
    assert_equal nil, to_wiki(nil)
  end
  
  test "to wiki with text" do
    assert_equal "<p>hello <strong>this is bold</strong></p>", to_wiki("hello *this is bold*")
  end
  
  test "to wiki with links to existing page" do
    get :index
    assert_equal "<p>bla <a href=\"/mini_wiki/HomePage\" class=\"wiki_link\">HomePage</a> bla</p>",
                 to_wiki("bla [[HomePage]] bla")
  end

  test "to wiki with links to non existing page and authorized" do
    get :index
    @authorized = true
    assert_equal "<p><a href=\"/mini_wiki/new?name=HomePageNonExisting\" class=\"wiki_new_link\">HomePageNonExisting</a></p>",
                 to_wiki("[[HomePageNonExisting]]")
  end

  test "to wiki with links to non existing page" do
    @authorized = false
    assert_equal "<p><span class=\"wiki_new_link\">HomePageNonExisting</span></p>",
                 to_wiki("[[HomePageNonExisting]]")
  end
end