class AddEditMarkHomeworkaToHomeworks < ActiveRecord::Migration[5.2]
  def change
    add_column :homeworks, :edit_mark_homeworka, :string
    add_column :homeworks, :edit_mark_homeworkb, :string
    add_column :homeworks, :edit_mark_homeworkc, :string
  end
end
