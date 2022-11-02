class CreateGraphs < ActiveRecord::Migration[5.2]
  def change
    create_table :graphs do |t|
      t.integer :money
      t.date :date

      t.timestamps
    end
  end
end
