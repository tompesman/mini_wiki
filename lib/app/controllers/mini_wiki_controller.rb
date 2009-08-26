class MiniWikiController < ActionController::Base
  layout MINI_WIKI_CONFIG['layout'], :except => :preview
  append_view_path(File.dirname(__FILE__) + MINI_WIKI_CONFIG['views_path'])

  before_filter :authorized?, :username

   # load the default page
  def index
    puts 
    if MiniWikiPage.first(:conditions => ["name = ?", "HomePage"]) == nil
      redirect_to :action => 'new', :name => "HomePage"
    else
      redirect_to :action => 'show', :wiki_page => "HomePage"
    end
  end

  # lists all wikipages
  def list
    @wiki_pages = MiniWikiPage.all(:order => 'name')
    render :template => 'list'
  end

  # shows a wikipage, with a given revision
  def show
    @wiki_page = MiniWikiPage.find_by_name(params[:wiki_page])

    if !@wiki_page.nil?
      # get revision
      if params[:revision]
        @wiki_revision = @wiki_page.mini_wiki_revisions.first(:conditions => ["revision=?",params[:revision]])
      end
      
      # if retreive of revision failed or if no revision requested, get the last revision
      if (params[:revision] && @wiki_revision==nil) || !params[:revision]
        @wiki_revision = @wiki_page.mini_wiki_revision
      end
      
      render :template => 'show'
    else
      redirect_to :action => 'new', :name => params[:wiki_page]
    end
    
  end

  def search
    @search_names = MiniWikiPage.all(:conditions => ["name LIKE ? ",'%'+params[:search][:query]+'%'])
    @search_contents = MiniWikiPage.all(:conditions => ["test_revisions.`contents` LIKE ?", '%'+params[:search][:query]+'%'],
                                        :include => [:mini_wiki_revisions])
    
    render :template => 'search'
  end
  
  def recently_revised
    @wiki_pages = MiniWikiPage.all(:order => 'updated_at DESC', :limit => 10)
    render :template => 'recently_revised'
  end
  
  # new wikipage, set page name and username if available
  def new
    @wiki_page = MiniWikiPage.new
    if params[:name]
      @wiki_page.name = params[:name]
    end
    
    @wiki_revision = MiniWikiRevision.new
    if username
      @wiki_revision.author = @username
    end
    
    render :template => 'new'
  end

  # adds a new wikipage to database
  def create
    saved = false
    MiniWikiPage.transaction do
      @wiki_page = MiniWikiPage.new(params[:wiki_page])
      @wiki_revision = MiniWikiRevision.new(params[:wiki_revision])
      @wiki_revision.author = username
      saved = @wiki_page.save
      
      @wiki_page.mini_wiki_revisions << @wiki_revision 
      saved = @wiki_revision.save
      
      @wiki_page.mini_wiki_revision = @wiki_revision
      saved = @wiki_page.save
    end
    
    if saved
      flash[:notice] = 'Page was successfully created.'
      redirect_to :action => 'show', :wiki_page => @wiki_page.name
    else
      render :action => 'new', :template => 'new'
    end
  end

  # loads the last wikirevision to edit
  def edit
    @wiki_page = MiniWikiPage.find_by_name(params[:wiki_page])
    @wiki_revision = @wiki_page.mini_wiki_revision
    render :template => 'edit'
  end

  # saves a new revision to database
  def update

    saved = false
    MiniWikiPage.transaction do
      @wiki_page = MiniWikiPage.find_by_name(params[:wiki_page])
      @wiki_revision = MiniWikiRevision.new(params[:wiki_revision])
      @wiki_revision.revision = @wiki_page.mini_wiki_revisions.last.revision + 1
      if username
        @wiki_revision.author = username
      end
      @wiki_page.mini_wiki_revisions << @wiki_revision
      @wiki_page.mini_wiki_revision = @wiki_revision
      saved = @wiki_page.save
    end
    
    if saved    
      flash[:notice] = 'Page was successfully updated.'
      redirect_to :action => 'show', :wiki_page => @wiki_page.name
    else
      render :action => 'edit', :template => 'edit'
    end
  end

  # Returns the preview page
  def preview
    render :template => "/preview", :layout => false
  end
  
  # Sets a nother revision as active.
  def setrevision
    @wiki_page = MiniWikiPage.find_by_name(params[:wiki_page])
    @wiki_revision = @wiki_page.mini_wiki_revisions.find_by_revision(params[:setrevision])
    
    @wiki_page.mini_wiki_revision = @wiki_revision
    if @wiki_revision && @wiki_page.save
      flash[:notice] = 'Current page was successfully changed.'
      redirect_to :action => 'show', :wiki_page => @wiki_page.name
    else
      flash[:warning] = 'Failed to update the current page.'
      redirect_to :action => 'show', :wiki_page => @wiki_page.name, :revision => params[:setrevision]
    end
  end

  # removes a wikipage
  def destroy
    MiniWikiPage.find_by_name(params[:wiki_page]).destroy
    flash[:notice] = 'Page was successfully removed.'
    redirect_to :action => 'list'
  end
  
  # empty authorization method, override in controller
  def authorized?
    @authorized = true
  end
  # empty username method, override in controller
  def username
    @username = ""
  end
end