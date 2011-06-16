class User < ActiveRecord::Base
  has_many :authorizations, :dependent => :destroy
  has_one :rmu_authorization, :class_name => "Authorization",
                              :conditions => {:provider => 'github'}


  def self.create_from_hash!(hash)
    create(:name     => hash['user_info']['name'],
           :nickname => hash['user_info']['nickname'],
           :email    => hash['user_info']['email'])
  end

  def name
    read_attribute(:name) || nickname || "Anonymous ##{id}"
  end

  def admin?
    @admin ||= alumnus?
  end

  def alumnus?
    return false if rmu_authorization.nil?
    rmu_user = University::User.get(rmu_authorization.uid)
    return rmu_user && rmu_user.alumnus?
  end

  def refresh_names(hash)
    return if nickname && email

    update_attributes(:name     => hash['user_info']['name'],
                      :nickname => hash['user_info']['nickname'],
                      :email    => hash['user_info']['email'])
  end


end
