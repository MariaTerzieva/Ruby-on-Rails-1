class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.belongs_to :post, index:true
      t.string :body

      t.timestamps null: false
    end
  end
end
