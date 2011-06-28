xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0",  'xmlns:atom' => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title "Flow"
    xml.description "Mendicant University's Flow"
    xml.link "http://flow.rubymendicant.com"
    xml.send('atom:link', :href => "http://flow.rubymendicant.com/articles.rss", :rel => "self", :type => "application/rss+xml")
    @articles.each do |article|
      xml.item do
        xml.title article.title
        xml.description md(article.body)
        xml.author "#{article.author.email} (#{article.author.name})"
        xml.pubDate article.created_at.to_s(:rfc822)
        xml.link article.url
        xml.guid "http://flow.rubymendicant.com/articles/#{article.id}"
      end
    end
  end
end