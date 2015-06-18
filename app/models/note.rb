class Note < ActiveRecord::Base
  belongs_to :client

  def self.all_alkp
    where('deleted is NULL or deleted = ?', false)
  end

  def self.destroy note
    note = Note.find(note.id)
    note.update(deleted: true)
  end

end
