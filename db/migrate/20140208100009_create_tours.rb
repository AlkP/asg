class CreateTours < ActiveRecord::Migration
  def change
    create_table :tours do |t|
      t.string :name
      t.text :description
      t.text :note
      t.date :departure
      t.date :final

      t.boolean :archive
      t.boolean :deleted

      t.references  :client, index: true

      t.timestamps
    end
  end
end
