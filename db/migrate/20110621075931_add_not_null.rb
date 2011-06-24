class AddNotNull < ActiveRecord::Migration
  def self.up
    change_column_null :authorizations, :user_id,    false
    change_column_null :authorizations, :provider,   false
    change_column_null :authorizations, :uid,        false
    change_column_null :tags,           :name,       false
    change_column_null :taggings,       :article_id, false
    change_column_null :taggings,       :tag_id,     false
  end

  def self.down
    change_column_null :authorizations, :user_id,    true
    change_column_null :authorizations, :provider,   true
    change_column_null :authorizations, :uid,        true
    change_column_null :tags,           :name,       true
    change_column_null :taggings,       :article_id, true
    change_column_null :taggings,       :tag_id,     true
  end
end
