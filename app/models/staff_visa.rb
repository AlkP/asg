class StaffVisa < ActiveRecord::Base
  belongs_to :staff

  def self.all_alkp
    where('deleted is NULL or deleted = ?', false)
  end

  def self.destroy staff_visa
    staff_visa = StaffVisa.find(staff_visa.id)
    staff_visa.update(deleted: true)
  end

end
