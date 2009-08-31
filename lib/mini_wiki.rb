# MiniWiki

# Load config
if File.exist?("#{RAILS_ROOT}/config/mini_wiki.yml")
  MINI_WIKI_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/mini_wiki.yml")['mini_wiki']
end

# Required modules
require 'redcloth'
require 'mini_wiki/commands'
require 'mini_wiki/routing'

# Load the models/controller/helpers
%w{ models controllers helpers }.each do |dir|
  path = File.join(File.dirname(__FILE__), 'app', dir)
  $LOAD_PATH << path
  ActiveSupport::Dependencies.load_paths << path
  ActiveSupport::Dependencies.load_once_paths.delete(path)
end 

