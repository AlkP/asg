class CreateTourRooms < ActiveRecord::Migration
  def change
    create_table :tour_rooms do |t|
      t.string      :name

      t.references  :tour, index: true
      t.references  :partner, index: true

      t.timestamps
    end
  end
end
