class CreateTourNotes < ActiveRecord::Migration
  def change
    create_table :tour_notes do |t|
      t.string :name
      t.boolean :deleted

      t.references  :tour, index: true

      t.timestamps
    end
  end
end
