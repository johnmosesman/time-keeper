class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title
      t.float :amount
      t.references :user, index: true

      t.timestamps
    end
  end
end
