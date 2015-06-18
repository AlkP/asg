class TourNote < ActiveRecord::Base
  belongs_to :tour

  def self.all_alkp
    where('deleted is NULL or deleted = ?', false)
  end

  def self.destroy tour_note
    tour_note = TourNote.find(tour_note.id)
    tour_note.update(deleted: true)
  end

end
