require File.dirname(__FILE__) + '/test_helper.rb'

class MiniWikiControllerTest < ActionController::TestCase
  
  # TODO: with/wo authentication
  # TODO: with empty content
  
  test "should get index with an empty db and gets redirected to new" do
    MiniWikiPage.find(1).destroy
    MiniWikiPage.find(2).destroy
    
    get :index
    assert_response :redirect
    assert_redirected_to :controller => "mini_wiki", :action => "new", :name => "HomePage"
  end
  
  test "should get index with a nonempty db and gets redirected to show" do
    get :index
    assert_response :redirect
    assert_redirected_to :controller => "mini_wiki", :action => "show", :wiki_page => "HomePage"
  end  

  test "list filled db" do
    get :list
  end
  
  test "list empty db" do
    get :list
  end
  
  test "should show an exsisting page" do
    get :show, :wiki_page => mini_wiki_pages(:HomePage).name
    assert_not_nil assigns(:wiki_page)
    assert_not_nil assigns(:wiki_revision)
    assert_response :success
    assert_template :show
  end
  
  test "should show an exsisting page with non current revision" do
    get :show, :wiki_page => mini_wiki_pages(:HomePage).name, :revision => 2
    assert_not_nil assigns(:wiki_page)
    assert_not_nil assigns(:wiki_revision)
    assert_response :success
    assert_template :show
  end

  test "should redirect a non exsisting page" do
    get :show, :wiki_page => "Not a exsisting page"
    assert_response :redirect
    assert_redirected_to :controller => "mini_wiki", :action => "new", :name => "Not a exsisting page"
  end
  
  # TODO: test search on title/content/empty db
  test "should show search results" do
    post :search, :search => { :query => "Test" }
    assert_response :success
    assert_template :search
  end
  
  # TODO: empty db
  test "recently_revised" do
    get :recently_revised
    assert_response :success
    assert_template :recently_revised
  end
  
  test "should show the new page" do
    get :new
    assert_not_nil assigns(:wiki_page)
    assert_not_nil assigns(:wiki_revision)
    assert_response :success
    assert_template :new
  end
  
  test "should show the new page with name" do
    get :new, :name => 'NewPage'
    assert_not_nil assigns(:wiki_page)
    assert_not_nil assigns(:wiki_revision)
    assert_response :success
    assert_template :new
  end

  test "should create a wiki in the database" do
    assert_difference('MiniWikiPage.count') do
      assert_difference('MiniWikiRevision.count') do
        post :create, :wiki_page => { :name => "NewPage" }, 
                      :wiki_revision => { :author => "Test user", :contents => "text"}
      end
    end
    assert_equal MiniWikiPage.find_by_name("NewPage").mini_wiki_revision.contents, "text"

    assert_response :redirect
    assert_redirected_to :controller => "mini_wiki", :action => "show", :wiki_page => "NewPage"
    assert !flash.empty?
  end

  test "should not create a wiki in the database" do
    assert_no_difference('MiniWikiPage.count') do
      assert_no_difference('MiniWikiRevision.count') do
        post :create, :wiki_page => { :name => "NewPage" }, 
                      :wiki_revision => { :author => "Test user", :contents => ""}
      end
    end

    assert_response :success
    assert_template :new
  end
  
  test "should show the edit page" do
    get :edit, :wiki_page => mini_wiki_pages(:HomePage).name
    assert_not_nil assigns(:wiki_page)
    assert_not_nil assigns(:wiki_revision)
    assert_response :success
    assert_template :edit
  end
  
  test "should update a wiki in the database" do
    assert_difference('MiniWikiRevision.count', +1) do
      assert_difference('MiniWikiPage.find_by_name("HomePage").mini_wiki_revision.revision', +1) do
        put :update, :wiki_page => mini_wiki_pages(:HomePage).name, 
                     :wiki_revision => { :author => "Other user", :contents => "text added" }
      end
    end
    assert_equal MiniWikiPage.find_by_name("HomePage").mini_wiki_revision.contents, "text added"
    
    assert_response :redirect
    assert_redirected_to :controller => "mini_wiki", :action => "show", :wiki_page => "HomePage"
  end
  
  test "should not update a wiki in the database" do
    assert_no_difference('MiniWikiRevision.count') do
      assert_no_difference('MiniWikiPage.count') do
        put :update, :wiki_page => mini_wiki_pages(:HomePage).name, 
                     :wiki_revision => { :author => "Other user", :contents => "" }
      end
    end
    assert_equal MiniWikiPage.find_by_name("HomePage").mini_wiki_revision.contents, "very very long story"
    
    assert_response :success
    assert_template :edit
  end
  
  test "should render a preview template" do
    get :preview
    assert_template :preview
  end
  
  test "should setrevision to an other one" do
    assert_difference('MiniWikiPage.find_by_name("HomePage").mini_wiki_revision.revision', -1) do
      put :setrevision, :setrevision => 2, :wiki_page => mini_wiki_pages(:HomePage).name
    end
    
    assert_not_nil assigns(:wiki_page)
    assert_not_nil assigns(:wiki_revision)
    assert_response :redirect
    assert_redirected_to :controller => "mini_wiki", :action => "show", :wiki_page => "HomePage"
  end
  
  test "should not setrevision to an other one" do
    assert_no_difference('MiniWikiPage.find_by_name("HomePage").mini_wiki_revision.revision') do
      put :setrevision, :setrevision => 4, :wiki_page => mini_wiki_pages(:HomePage).name
    end

    assert_not_nil assigns(:wiki_page)
    assert_nil assigns(:wiki_revision)
    assert_response :redirect
    assert_redirected_to :controller => "mini_wiki", :action => "show", :wiki_page => "HomePage", :revision => 4
  end
  
  test "should destroy wiki page" do
    assert_difference('MiniWikiRevision.count', -2) do
      assert_difference('MiniWikiPage.count', -1) do
        delete :destroy, :wiki_page => mini_wiki_pages(:TestPage).name
      end
    end

    assert_response :redirect
    assert_redirected_to :controller => "mini_wiki", :action => "list"
  end
  
#  test "authorized?" do
#
#  end
#  
#  test "username" do
#    
#  end

end