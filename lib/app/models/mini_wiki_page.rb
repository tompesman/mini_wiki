class MiniWikiPage < ActiveRecord::Base
  has_many :mini_wiki_revisions, :order => "revision", :dependent => :destroy
  belongs_to :mini_wiki_revision
  
  validates_presence_of :name
  validates_uniqueness_of :name  
  validates_exclusion_of :name, :in => %w( new create list search recently_revised preview ), :message => "Reserved name for route"
end 