class StaffNote < ActiveRecord::Base
  belongs_to :staff

  def self.all_alkp
    where('deleted is NULL or deleted = ?', false)
  end

  def self.destroy staff_note
    staff_note = StaffNote.find(staff_note.id)
    staff_note.update(deleted: true)
  end
end
