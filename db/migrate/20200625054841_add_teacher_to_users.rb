class AddTeacherToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :teacher, :boolean, default: false
    add_column :users, :search, :string
    add_column :users, :teacher_uid, :string
    add_column :users, :student_uid, :string
    add_column :users, :category_class, :string
  end
end
