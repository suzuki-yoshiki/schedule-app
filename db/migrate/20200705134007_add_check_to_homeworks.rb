class AddCheckToHomeworks < ActiveRecord::Migration[5.2]
  def change
    add_column :homeworks, :check, :boolean
  end
end
