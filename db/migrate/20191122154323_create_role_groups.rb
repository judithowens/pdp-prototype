class CreateRoleGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :role_groups do |t|
      t.string :name

      t.timestamps
    end
    add_reference :roles, :role_group, foreign_key: true
  end
end
