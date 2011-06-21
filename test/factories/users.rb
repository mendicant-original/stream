Factory.define :user do |f|
  f.name "User"
end

Factory.define :john, :class => User do |f|
  f.name "John"
end

Factory.define :mary, :class => User do |f|
  f.name "Mary"
end

Factory.define :admin, :class => User do |f|
  f.name  "Admin"
  f.admin true
end
