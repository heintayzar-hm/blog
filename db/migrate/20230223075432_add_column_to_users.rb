class AddColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :photo, :string, default: "https://media.istockphoto.com/id/522855255/vector/male-profile-flat-blue-simple-icon-with-long-shadow.webp?s=1024x1024&w=is&k=20&c=5N-Iz1UOhe91VvIgSw4Cc1xEmjvUF234f6aFk1FnZNc="
    add_column :users, :bio, :text
    add_column :users, :posts_counter, :integer, default: 0
  end
end
