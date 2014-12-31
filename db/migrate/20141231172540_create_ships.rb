class CreateShips < ActiveRecord::Migration
  def change
    create_table :ships do |t|
      t.string :name
      t.integer :size

      t.timestamps null: false
    end
  end
end
