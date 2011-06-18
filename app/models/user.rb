class User < ActiveRecord::Base
  has_many :article
end
