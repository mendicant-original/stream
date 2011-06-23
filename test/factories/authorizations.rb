# Note: user associations are set via user factory after_create callbacks, not here

Factory.define :authorization, :class => Authorization do |f|
  f.provider 'github'
  f.uid '12345'
#  f.association :user
end

Factory.define :john_authorization, :class => Authorization do |f|
  f.provider 'github'
  f.uid '23456'
#  f.association :user, :factory => :john
end

Factory.define :mary_authorization, :class => Authorization do |f|
  f.provider 'github'
  f.uid '34567'
#  f.association :user, :factory => :mary
end

Factory.define :admin_authorization, :class => Authorization do |f|
  f.provider 'github'
  f.uid '45678'
#  f.association :user, :factory => :admin
end
