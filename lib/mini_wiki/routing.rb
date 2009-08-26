module MiniWiki #:nodoc:
  module Routing #:nodoc:
    module MapperExtensions
      def mini_wiki
        
        @set.add_route('/mini_wiki/new', {:controller => 'mini_wiki', :action => 'new'})
        @set.add_route('/mini_wiki/create', {:controller => 'mini_wiki', :action => 'create'})
        @set.add_route('/mini_wiki/list', {:controller => 'mini_wiki', :action => 'list'})
        @set.add_route('/mini_wiki/search', {:controller => 'mini_wiki', :action => 'search'})
        @set.add_route('/mini_wiki/recently_revised', {:controller => 'mini_wiki', :action => 'recently_revised'})
        @set.add_route('/mini_wiki/preview', {:controller => 'mini_wiki', :action => 'preview'})
        
        @set.add_route('/mini_wiki/:wiki_page', {:controller => 'mini_wiki', :action => 'show'})
        
        @set.add_route('/mini_wiki/:wiki_page/revision/:revision', {:controller => 'mini_wiki', :action => 'show'})
        @set.add_route('/mini_wiki/:wiki_page/setrevision/:setrevision', {:controller => 'mini_wiki', :action => 'setrevision'})
        @set.add_route('/mini_wiki/:wiki_page/edit', {:controller => 'mini_wiki', :action => 'edit'})
        @set.add_route('/mini_wiki/:wiki_page/update', {:controller => 'mini_wiki', :action => 'update'})
        @set.add_route('/mini_wiki/:wiki_page/destroy', {:controller => 'mini_wiki', :action => 'destroy'})
        
        @set.add_route('/mini_wiki', {:controller => 'mini_wiki', :action => 'index'})  
      end
    end
  end
end

ActionController::Routing::RouteSet::Mapper.send :include, MiniWiki::Routing::MapperExtensions 