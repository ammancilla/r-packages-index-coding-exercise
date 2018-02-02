class CreateMaintainersPackages < ActiveRecord::Migration[5.1]
  def change
    create_table :maintainers_packages do |t|
      t.references :person, foreign_key: true, null: false
      t.references :package, foreign_key: true, null: false

      t.timestamps
    end
  end
end
