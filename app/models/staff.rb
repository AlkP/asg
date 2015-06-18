class Staff < ActiveRecord::Base
  has_many :staff_note, dependent: :destroy
  has_many :staff_visa, dependent: :destroy
  belongs_to :client
  has_many :room_staff, dependent: :destroy
  has_many :event, dependent: :destroy

  def self.all_alkp(session = nil)
    if session.nil?
      where('deleted is NULL or deleted = ?',false)
    else
      if session[:name].nil? or session[:sector].nil?
        unless session[:name].nil?
          where('deleted is NULL or deleted = ?',false).by_name session[:name]
        else
          where('deleted is NULL or deleted = ?',false).where('sector_id = ?', session[:sector])
        end
      else
        where('deleted is NULL or deleted = ?',false).where('sector_id = ?', session[:sector]).by_name session[:name]
      end
    end
  end
  def self.accept_filter(session = nil)
    staffs = Staff.all_alkp.order('updated_at DESC')
    unless session.nil?
      staffs = staffs.by_date_year(session[:date][:year]) unless session[:date][:year].nil?
      staffs = staffs.by_date_month(session[:date][:month]) unless session[:date][:month].nil?
      staffs = staffs.by_date_day(session[:date][:day]) unless session[:date][:day].nil?

      staffs = staffs.where('sex = ?',session[:sex]) unless session[:sex].nil?
      staffs = staffs.where("client_id in (?)",session[:client_id]) unless session[:client_id].nil?
    end
    staffs
  end
  def self.destroy staff
    staff = Staff.find(staff.id)
    staff.update(deleted: true)
  end
  scope :by_date_year, ->(year) { where("strftime('%Y', birthday)   = ?", year) }
  scope :by_date_month, ->(month) { where("strftime('%m', birthday) = ?", month) }
  scope :by_date_day, ->(day) { where("strftime('%d', birthday)     = ?", day) }

  scope :today, lambda { WHERE("created_at BETWEEN '#{DateTime.now.beginning_of_day}' AND '#{DateTime.now.end_of_day}'") }

end
