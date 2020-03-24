class AddReferenceConsultationSpotToTasks < ActiveRecord::Migration[5.2]
  def change
    add_reference :tasks, :consultation_spot, foreign_key: true
  end
end
