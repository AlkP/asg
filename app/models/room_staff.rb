class RoomStaff < ActiveRecord::Base
  belongs_to :tour_room
  belongs_to :staff
end
