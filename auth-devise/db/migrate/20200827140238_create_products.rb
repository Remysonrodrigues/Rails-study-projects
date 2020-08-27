class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :description
      t.integer :quantity

      t.timestamps
    end
  end
end
