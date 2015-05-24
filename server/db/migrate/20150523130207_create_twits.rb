class CreateTwits < ActiveRecord::Migration
  def change
    create_table :twits do |t|
      t.string :body
      t.integer :origin_id, index: true, unique: true, limit: 8
      t.datetime :twit_date
      t.references :author, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
