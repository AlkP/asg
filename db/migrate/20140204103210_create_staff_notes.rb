class CreateStaffNotes < ActiveRecord::Migration
  def change
    create_table :staff_notes do |t|
      t.string :name
      t.string :description
      t.boolean :deleted

      t.references  :staff, index: true

      t.timestamps
    end
  end
end
