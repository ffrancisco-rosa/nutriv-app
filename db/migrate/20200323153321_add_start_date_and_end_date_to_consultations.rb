class AddStartDateAndEndDateToConsultations < ActiveRecord::Migration[5.2]
  def change
    add_column :consultations, :start_date, :datetime
    add_column :consultations, :end_date, :datetime
    add_reference :consultations, :consultation_spot, foreign_key: true
  end
end
