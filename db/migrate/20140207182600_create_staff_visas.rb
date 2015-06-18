class CreateStaffVisas < ActiveRecord::Migration
  def change
    create_table :staff_visas do |t|
      t.date :validity
      t.boolean :deleted

      t.references  :country, index: true
      t.references  :staff, index: true

      t.timestamps
    end
  end
end
