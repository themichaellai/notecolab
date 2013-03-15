class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :title, null: false
      t.string :description
      t.text :body
      t.integer :course_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
