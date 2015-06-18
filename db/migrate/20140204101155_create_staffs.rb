class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.string :name
      t.string :surname
      t.string :middle_name
      t.string :series
      t.string :issued_by
      t.string :issue_date
      t.string :valid_until

      t.string :international_name
      t.string :international_surname
      t.string :international_middle_name
      t.string :international_series
      t.string :international_issued_by
      t.string :international_issue_date
      t.string :international_valid_until

      t.string :sex
      t.string :post
      t.string :email_1
      t.string :email_2
      t.string :phone_1
      t.string :phone_2
      t.string :phone_3
      t.string :registration
      t.string :lives

      t.boolean :deleted

      t.references  :client, index: true

      t.timestamps
    end
  end
end
