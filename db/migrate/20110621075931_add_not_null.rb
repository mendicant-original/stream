class AddNotNull < ActiveRecord::Migration
  def self.up
    change_column :authorizations, :user_id,    :integer, :null => false
    change_column :authorizations, :provider,   :string,  :null => false
    change_column :authorizations, :uid,        :string,  :null => false
    change_column :tags,           :name,       :string,  :null => false
    change_column :taggings,       :article_id, :integer, :null => false
    change_column :taggings,       :tag_id,     :integer, :null => false
  end

  def self.down
    change_column :authorizations, :user_id,    :integer, :null => true
    change_column :authorizations, :provider,   :string,  :null => true
    change_column :authorizations, :uid,        :string,  :null => true
    change_column :tags,           :name,       :string,  :null => true
    change_column :taggings,       :article_id, :integer, :null => true
    change_column :taggings,       :tag_id,     :integer, :null => true
  end
end
