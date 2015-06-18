class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :legal_address
      t.string :actual_address
      t.string :inn
      t.string :kpp
      t.string :account
      t.string :name_bank
      t.string :corr_account
      t.string :bik
      t.string :job_title
      t.string :name_head
      t.string :job_title_genitive
      t.string :name_head_genitive
      t.string :statute
      t.boolean :deleted

      t.references  :sector, index: true

      t.timestamps
    end
  end
end
