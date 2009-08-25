class MiniWikiGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      # add the migration
      m.migration_template 'add_mini_wiki.rb', "db/migrate", { :migration_file_name => "add_mini_wiki" }  
    end
  end
end
