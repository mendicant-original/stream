Factory.define :user do |f|
  f.name "User"
  f.github 'generic'
end

Factory.define :john, :class => User do |f|
  f.name "John"
  f.github 'john'
end

Factory.define :mary, :class => User do |f|
  f.name "Mary"
  f.github 'mary'
end

Factory.define :admin, :class => User do |f|
  f.name  "Admin"
  f.github 'kingkong'
  f.admin true
end
