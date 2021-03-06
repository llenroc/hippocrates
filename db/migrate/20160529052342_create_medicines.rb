class CreateMedicines < ActiveRecord::Migration[5.1]
  def change
    create_table :medicines do |t|
      t.string :name,         null: false
      t.string :instructions, null: false

      t.timestamps            null: false
    end

    add_index :medicines, :name, unique: true
  end
end
