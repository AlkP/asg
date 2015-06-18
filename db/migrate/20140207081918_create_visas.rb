class CreateVisas < ActiveRecord::Migration
  def change
    create_table :visas do |t|
      t.integer :duration
      t.float   :cost
      t.boolean :deleted

      t.references  :country, index: true
      t.references  :partner, index: true

      t.timestamps
    end
  end
end
