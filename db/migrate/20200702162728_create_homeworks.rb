class CreateHomeworks < ActiveRecord::Migration[5.2]
  def change
    create_table :homeworks do |t|
      t.date :work_on
      t.string :note
      t.boolean :work_namea
      t.boolean :work_nameb
      t.boolean :work_namec
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
