class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      t.string :screen_name, unique: true
      t.integer :twitter_id, index: true, unique: true, limit: 8

      t.timestamps null: false
    end
  end
end
