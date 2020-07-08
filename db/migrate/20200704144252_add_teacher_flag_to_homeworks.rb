class AddTeacherFlagToHomeworks < ActiveRecord::Migration[5.2]
  def change
    add_column :homeworks, :teacher_flag, :string
  end
end
