class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :name
      t.string :description
      t.boolean :deleted

      t.references  :client, index: true

      t.timestamps
    end
  end
end
