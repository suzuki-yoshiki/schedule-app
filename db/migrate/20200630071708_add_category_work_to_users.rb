class AddCategoryWorkToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :category_work, :string
  end
end
