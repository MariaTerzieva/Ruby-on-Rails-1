class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.string :code
      t.belongs_to :task
    end
  end
end
