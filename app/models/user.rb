class User < ActiveRecord::Base
  has_many :articles,       :dependent => :destroy, :foreign_key => :author_id
  has_many :authorizations, :dependent => :destroy
  
  attr_accessible :name, :github, :email, :twitter, :location, :about
 
  def self.create_from_hash!(hash)
    create(:name     => hash['user_info']['name'],
           :github => hash['user_info']['nickname'],
           :email    => hash['user_info']['email'])
  end

  def refresh_names(hash)    
    return if github && email

    update_attributes(:name     => hash['user_info']['name'],
                      :github => hash['user_info']['nickname'],
                      :email    => hash['user_info']['email'])
  end
  
  def editable_by?(user)
    user.admin? || user == self
  end

  def gravatar_url(size=40)
    hash = Digest::MD5.hexdigest(email.downcase)

    "http://www.gravatar.com/avatar/#{hash}?s=#{size}&d=mm"
  end

end
