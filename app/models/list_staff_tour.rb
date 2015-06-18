class ListStaffTour < ActiveRecord::Base

  def self.check(list, id)
    flag = nil
    list.each do |f|
      if f.staff_id == id
        flag = true
      end
    end
    flag.nil? ? false : true
  end
end
