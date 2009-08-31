require 'rails_generator' 
require 'rails_generator/commands' 

module MiniWiki #:nodoc:  
  module Generator #:nodoc:  
    module Commands #:nodoc:  
      module Create 
        def mini_wiki_route 
          logger.route "map.mini_wiki"  
          look_for = 'ActionController::Routing::Routes.draw do |map|'  
          unless options[:pretend] 
            gsub_file('config/routes.rb', /(#{Regexp.escape(look_for)})/mi){|match| "#{match}\n  map.mini_wiki\n"}  
          end
        end
      end
      module Destroy 
        def mini_wiki_route 
          logger.route "map.mini_wiki"  
          gsub_file 'config/routes.rb', /\n.+?map\.mini_wiki\n/mi, ''  
        end
      end
      module List 
        def mini_wiki_route 
        end
      end  
      module Update 
        def mini_wiki_route 
        end
      end  
    end  
  end 
end

Rails::Generator::Commands::Create.send  :include, MiniWiki::Generator::Commands::Create 
Rails::Generator::Commands::Destroy.send  :include, MiniWiki::Generator::Commands::Destroy 
Rails::Generator::Commands::List.send  :include, MiniWiki::Generator::Commands::List 
Rails::Generator::Commands::Update.send  :include, MiniWiki::Generator::Commands::Update 