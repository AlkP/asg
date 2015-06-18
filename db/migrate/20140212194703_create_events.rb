class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string  :name
      t.string  :description
      t.string  :note
      t.date    :date
      t.time    :time
      t.boolean :end

      t.references  :user, index: true
      t.references  :client, index: true
      t.references  :staff, index: true
      t.references  :tour, index: true
      t.references  :partner, index: true

      t.timestamps
    end
  end
end
