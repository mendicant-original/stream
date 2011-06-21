class BuildTables < ActiveRecord::Migration
  def self.up
    create_table "authorizations", :force => true do |t|
      t.belongs_to :user
      t.string   "provider"
      t.string   "uid"

      t.timestamps
    end

    create_table "tags" do |t|
      t.string  "name"

      t.timestamps
    end

    create_table "articles" do |t|
      t.belongs_to :author, :class_name => "User"
      
      t.boolean "official"
      t.string  "url"
      t.string  "title"
      t.text    "body"

      t.timestamps
    end

    create_table "taggings" do |t|
      t.belongs_to :tag
      t.belongs_to :article

      t.timestamps
    end

    create_table "users" do |t|
      t.boolean "admin", :default => false
      t.string  "name"
      t.string  "github"
      t.string  "email"
      t.string  "twitter"
      t.string  "location"
      t.text    "about"

      t.timestamps
    end
  end

  def self.down
    drop_table :authorizations
    drop_table :tags
    drop_table :articles
    drop_table :taggings
    drop_table :users
  end
end
