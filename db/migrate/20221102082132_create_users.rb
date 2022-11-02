class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :pass
      t.binary :icon
      t.integer :money
      t.integer :debt
      t.integer :visits
      t.date :final_date

      t.timestamps
    end
  end
end
