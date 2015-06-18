class CreateListStaffTours < ActiveRecord::Migration
  def change
    create_table :list_staff_tours do |t|

      t.references  :tour, index: true
      t.references  :staff, index: true

      t.timestamps
    end
  end
end
