class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.float :amount
      t.references :category, index: true

      t.timestamps
    end
  end
end
