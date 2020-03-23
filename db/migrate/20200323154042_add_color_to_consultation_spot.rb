class AddColorToConsultationSpot < ActiveRecord::Migration[5.2]
  def change
    add_column :consultation_spots, :color, :string
  end
end
