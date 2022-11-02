class CreateReceptions < ActiveRecord::Migration[5.2]
  def change
    create_table :receptions do |t|
      t.integer :user_id
      t.integer :money
      t.integer :type

      t.timestamps
    end
  end
end
