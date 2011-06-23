class AddNotNull < ActiveRecord::Migration
  def self.up
    change_column_null :authorizations, :user_id,    :null => false
    change_column_null :authorizations, :provider,   :null => false
    change_column_null :authorizations, :uid,        :null => false
    change_column_null :tags,           :name,       :null => false
    change_column_null :taggings,       :article_id, :null => false
    change_column_null :taggings,       :tag_id,     :null => false
  end

  def self.down
    change_column_null :authorizations, :user_id,    :null => true
    change_column_null :authorizations, :provider,   :null => true
    change_column_null :authorizations, :uid,        :null => true
    change_column_null :tags,           :name,       :null => true
    change_column_null :taggings,       :article_id, :null => true
    change_column_null :taggings,       :tag_id,     :null => true
  end
end
