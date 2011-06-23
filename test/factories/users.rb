Factory.define :user do |f|
  f.name "User"
  f.github 'generic'
  f.email 'someone@somewhere.com'
  f.after_create {|u| Factory(:authorization, :user => u) }
end

Factory.define :john, :class => User do |f|
  f.name "John"
  f.github 'johnnie'
  f.email 'x@y.net'
  f.after_create {|u| Factory(:john_authorization, :user => u) }
end

Factory.define :mary, :class => User do |f|
  f.name "Mary"
  f.github 'queenofscots'
  f.email 'mary@queenofscots.gov'
  f.after_create {|u| Factory(:mary_authorization, :user => u) }
end

Factory.define :admin, :class => User do |f|
  f.name  "Admin"
  f.github 'kingkong'
  f.email 'bingo@bongo.com'
  f.admin true
  f.after_create {|u| Factory(:admin_authorization, :user => u) }
end
