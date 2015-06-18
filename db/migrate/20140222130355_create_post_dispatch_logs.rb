class CreatePostDispatchLogs < ActiveRecord::Migration
  def change
    create_table :post_dispatch_logs do |t|
      t.references  :post_dispatch, index: true

      t.timestamps
    end
  end
end
