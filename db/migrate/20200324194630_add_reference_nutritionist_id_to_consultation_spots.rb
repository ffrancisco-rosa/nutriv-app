class AddReferenceNutritionistIdToConsultationSpots < ActiveRecord::Migration[5.2]
  def change
    add_reference :consultation_spots, :nutritionist
  end
end
