class MiniWikiGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      # add the migration
      m.migration_template 'add_mini_wiki.rb', 'db/migrate', { :migration_file_name => 'add_mini_wiki' }  
      
      # layout
      m.directory "app/views/layouts"
      m.file 'layouts/mini_wiki.html.erb', 'app/views/layouts/mini_wiki.html.erb'

      # css
      m.directory "public/stylesheets"
      m.file 'css/mini_wiki.css', 'public/stylesheets/mini_wiki.css'

      # config
      m.directory "config"
      m.file 'config/mini_wiki.yml', 'config/mini_wiki.yml'
      
      # lib
      m.directory "lib"
      m.file 'lib/mini_wiki_override.rb', 'lib/mini_wiki_override.rb'
      
      # add route
      m.mini_wiki_route
    end
  end
end
