class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.string :name, :null => false
      t.integer :sfia_grade, :null => false

      t.timestamps
    end
    add_reference :users, :role, foreign_key: true
  end
end
