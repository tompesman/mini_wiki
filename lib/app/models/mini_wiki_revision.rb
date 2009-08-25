class MiniWikiRevision < ActiveRecord::Base
  belongs_to :mini_wiki_page
  has_one :mini_wiki_page

  validates_presence_of :mini_wiki_page_id
  validates_presence_of :revision
  validates_uniqueness_of :revision, :scope => :mini_wiki_page_id
  validates_length_of :contents, :minimum=>1, :too_short=>"please enter at least %d character"
end 