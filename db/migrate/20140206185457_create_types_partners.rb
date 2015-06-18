class CreateTypesPartners < ActiveRecord::Migration
  def change
    create_table :types_partners do |t|
      t.string :name
      t.boolean :deleted

      t.timestamps
    end
  end
end
