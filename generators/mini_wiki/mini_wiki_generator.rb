class MiniWikiGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      # add the migration
      m.migration_template 'add_mini_wiki.rb', 'db/migrate', { :migration_file_name => 'add_mini_wiki' }  
      
      # layout
      m.file 'layouts/mini_wiki.html.erb', 'app/views/mini_wiki.css'

      # css
      m.file 'css/mini_wiki.css', 'public/stylesheets/mini_wiki.css'

      # config
      m.file 'config/mini_wiki.yml', 'config/mini_wiki.yml'
    end
  end
end
