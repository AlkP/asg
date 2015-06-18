class CreateRoomStaffs < ActiveRecord::Migration
  def change
    create_table :room_staffs do |t|

      t.references  :tour_room, index: true
      t.references  :staff, index: true

      t.timestamps
    end
  end
end
