class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, null:false
      t.belongs_to :brand, index:true, null:false
      t.belongs_to :category, index:true, null:false
      t.integer :price, null:false
      t.integer :quantity, null:false

      t.timestamps null: false
    end
  end
end
