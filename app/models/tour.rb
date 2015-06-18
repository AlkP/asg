class Tour < ActiveRecord::Base
  belongs_to :client
  has_many :tour_note, dependent: :destroy
  has_many :tour_room, dependent: :destroy
  has_many :event, dependent: :destroy

  def self.all_alkp
    where('deleted is NULL or deleted = ?', false)
  end

  def self.destroy tour
    tour = Tour.find(tour.id)
    tour.update(deleted: true)
  end

  def self.current_tours
    where('(archive is NULL or archive = ?) and final >= ?', false, Date.today)
  end

  def self.arhive_tours
    where('archive = ? or final < ?', true, Date.today)
  end

end
