class CreateTowns < ActiveRecord::Migration
  def change
    create_table :towns do |t|
      t.string :name
      t.string :international_name
      t.boolean :deleted

      t.references  :country, index: true

      t.timestamps
    end
  end
end
