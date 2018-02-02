class CreateVersions < ActiveRecord::Migration[5.1]
  def change
    create_table :versions do |t|
      t.string :name, null: false
      t.timestamp :published_at, null: false
      t.references :package, foreign_key: true, null: false

      t.timestamps
    end
  end
end
