class AddMiniWiki < ActiveRecord::Migration
  def self.up
    create_table "mini_wiki_pages", :force => true do |t|
      t.column "name",       :string,   :default => "", :null => false
      t.references :mini_wiki_revision
      t.timestamps
    end
  
    create_table "mini_wiki_revisions", :force => true do |t|
      t.column "author",       :string
      t.column "revision",     :integer,  :default => 1,  :null => false
      t.column "contents",     :text,     :default => "", :null => false
      t.references :mini_wiki_page
      t.timestamps
    end
    
  end

  def self.down
    drop_table :mini_wiki_revisions
    drop_table :mini_wiki_pages
  end
end