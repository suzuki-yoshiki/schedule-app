class AddWorkCheckToHomeworks < ActiveRecord::Migration[5.2]
  def change
    add_column :homeworks, :work_check, :string
    add_column :homeworks, :mark_homeworka, :string
    add_column :homeworks, :mark_homeworkb, :string
    add_column :homeworks, :mark_homeworkc, :string
  end
end
