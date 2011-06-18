class BuildTables < ActiveRecord::Migration
  def self.up
    create_table "authorizations", :force => true do |t|
      t.belongs_to :user
      t.string   "provider"
      t.string   "uid"

      t.timestamps
    end

    create_table "tags" do |t|
      t.integer "id"
      t.string  "name"

      t.timestamps
    end

    create_table "articles" do |t|
      t.belongs_to :author, :class => "User"
      
      t.integer "id"
      t.boolean "official"
      t.string  "url"
      t.string  "title"
      t.text    "body"

      t.timestamps
      #has_many   :tags
    end

    create_table "taggings" do |t|
      #t.integer "tag_id"
      #t.integer "article_id"
      t.belongs_to :tag
      t.belongs_to :article

      t.timestamps
    end

    create_table "users" do |t|
      t.integer "id"
      t.boolean "admin"
      t.string  "name"
      t.string  "github"
      t.string  "email"
      t.string  "twitter"
      t.string  "location"
      t.text    "about"

      t.timestamps
      #has_many :articles
      #has_many :authorizations
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
