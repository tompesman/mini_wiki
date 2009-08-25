require File.dirname(__FILE__) + '/test_helper.rb'
require 'mini_wiki_controller'
require 'action_controller/test_process'

class MiniWikiController; def rescue_action(e) raise e end; end
  
class MiniWikiControllerTest < ActionController::TestCase
  
  def setup
    @controller = MiniWikiController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
    ActionController::Routing::Routes.draw do |map|
      map.connect '/wiki', :controller => 'mini_wiki', :action => 'index'
      #map.resources :mini_wiki_pages
    end
  end
  
  # TODO
  
  def test_index
    get :index
    assert_response :redirect
  end
end 