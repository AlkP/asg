class AddBdToStaff < ActiveRecord::Migration
  def change
    change_table :staffs do |t|
      t.date :birthday
    end
  end
end
