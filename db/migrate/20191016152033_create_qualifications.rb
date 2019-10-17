class CreateQualifications < ActiveRecord::Migration[6.0]
  def change
    create_table :qualifications do |t|
      t.integer :user_id
      t.string :name, :null => false
      t.date :awarded_date, :null => false
      t.date :expiry_date
      t.string :grade
      t.text :details
      t.timestamps
    end
    add_foreign_key :qualifications, :users
  end
end
