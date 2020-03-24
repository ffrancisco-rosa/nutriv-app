class UpdateColorInConsultationsSpots < ActiveRecord::Migration[5.2]
  def change
    remove_column :consultation_spots, :color
    add_column :consultation_spots, :color, :integer
  end
end
