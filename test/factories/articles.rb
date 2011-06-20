Factory.define :john_article, :class => Article do |f|
  f.association :author, :factory => :john
  f.title  "Rails 3"
  f.url    "http://weblog.rubyonrails.org"
  f.body   "Rails 3 is coming!"
end

Factory.define :mary_article, :class => Article do |f|
  f.association :author, :factory => :mary
  f.title "Java rocks!"
  f.url   "http://java.com"
  f.body  "Java enterprisey rocks."
end
