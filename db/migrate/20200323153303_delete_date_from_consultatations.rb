class DeleteDateFromConsultatations < ActiveRecord::Migration[5.2]
  def change
    remove_column :consultations, :date
  end
end
