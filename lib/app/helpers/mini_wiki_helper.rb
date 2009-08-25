module MiniWikiHelper
  def to_wiki(contents)
    # search for links
    links = contents.scan(/\[\[[A-Za-z ]+\]\]/)
    for link in links
      page = link.scan(/[A-Za-z ]+/).first
      if MiniWikiPage.find_by_name(page)
        linkto = link_to page, {:action => 'show', :wiki_page => page}, :class => 'wiki_link'
      elsif !@authorized
        linkto = '<span class="wiki_new_link">'+page+'</span>'
      else
        linkto = link_to page, {:action => 'new', :name => page}, :class => 'wiki_new_link'
      end
      contents = contents.gsub(Regexp.new(Regexp.escape(link)),linkto)
    end
    
    # wiki to html
    contents = RedCloth.new(contents).to_html
    
    return contents
  end
end