class CreateConsultations < ActiveRecord::Migration[5.2]
  def change
    create_table :consultations do |t|
      t.date :date
      t.boolean :status
      t.references :nutritionist
      t.references :customer

      t.timestamps
    end
  end
end
