ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../../../../config/environment")
require 'test_help'

class ActiveSupport::TestCase
  # Transactional fixtures accelerate your tests by wrapping each test method
  # in a transaction that's rolled back on completion.  This ensures that the
  # test database remains unchanged so your fixtures don't have to be reloaded
  # between every test method.  Fewer database queries means faster tests.
  #
  # Read Mike Clark's excellent walkthrough at
  #   http://clarkware.com/cgi/blosxom/2005/10/24#Rails10FastTesting
  #
  # Every Active Record database supports transactions except MyISAM tables
  # in MySQL.  Turn off transactional fixtures in this case; however, if you
  # don't care one way or the other, switching from MyISAM to InnoDB tables
  # is recommended.
  #
  # The only drawback to using transactional fixtures is when you actually 
  # need to test transactions.  Since your test is bracketed by a transaction,
  # any transactions started in your code will be automatically rolled back.
  self.use_transactional_fixtures = false

  # Instantiated fixtures are slow, but give you @david where otherwise you
  # would need people(:david).  If you don't want to migrate your existing
  # test cases which use the @david style and don't mind the speed hit (each
  # instantiated fixtures translates to a database query per test method),
  # then set this back to true.
  self.use_instantiated_fixtures  = false

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all
  
  self.fixture_path = File.dirname(__FILE__) + "/fixtures/"
  #$LOAD_PATH.unshift(ActiveSupport::TestCase.fixture_path)

  # Add more helper methods to be used by all tests here...
end

def load_schema
  config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
  ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")
  db_adapter = ENV['DB']
  
  # no db passed, try one of these fine config-free DBs before bombing.  
  db_adapter ||=
    begin 
      require 'rubygems'  
      require 'sqlite'
      'sqlite'  
    rescue MissingSourceFile 
      begin
        require 'sqlite3'
        'sqlite3'  
      rescue MissingSourceFile
      end
    end
  
  if db_adapter.nil? 
    raise "No DB Adapter selected. Pass the DB= option to pick one, or install Sqlite or Sqlite3."  
  end
  
  ActiveRecord::Base.establish_connection(config[db_adapter])
  load(File.dirname(__FILE__) + "/schema.rb")
  require File.dirname(__FILE__) + '/../rails/init.rb'
end
load_schema