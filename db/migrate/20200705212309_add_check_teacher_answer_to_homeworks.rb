class AddCheckTeacherAnswerToHomeworks < ActiveRecord::Migration[5.2]
  def change
    add_column :homeworks, :check_teacher_answer, :string
  end
end
