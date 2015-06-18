class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.string :international_name
      t.boolean :deleted

      t.timestamps
    end
  end
end
