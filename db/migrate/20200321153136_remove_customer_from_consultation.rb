class RemoveCustomerFromConsultation < ActiveRecord::Migration[5.2]
  def change
    remove_reference :consultations, :customer
  end
end
