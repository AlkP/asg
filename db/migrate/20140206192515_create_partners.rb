class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.string :name
      t.string :address
      t.string :contact_name
      t.string :email
      t.string :phone
      t.string :description
      t.boolean :deleted

      t.references  :types_partner, index: true
      t.references  :country, index: true
      t.references  :town, index: true

      t.timestamps
    end
  end
end
