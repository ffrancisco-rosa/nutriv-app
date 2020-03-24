class AddNutritionistToTasks < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :user_id
    add_reference :tasks, :nutritionist
  end
end
