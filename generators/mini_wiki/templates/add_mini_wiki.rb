class AddMiniWiki < ActiveRecord::Migration
  def self.up
    create_table :mini_wiki_pages, :force => true do |t|
      t.string      :name, :default => "", :null => false
      t.references  :mini_wiki_revision
      t.timestamps
    end
  
    create_table :mini_wiki_revisions, :force => true do |t|
      t.string      :author
      t.text        :contents,    :default => "", :null => false
      t.integer     :revision, :default => 1,  :null => false
      t.references  :mini_wiki_page
      t.timestamps
    end
    
  end

  def self.down
    drop_table :mini_wiki_revisions
    drop_table :mini_wiki_pages
  end
end