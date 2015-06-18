class TourRoom < ActiveRecord::Base
  belongs_to :tour
  belongs_to :partner
  has_many :room_staff, dependent: :destroy
end
