class AddGuestToConsultation < ActiveRecord::Migration[5.2]
  def change
    add_reference :consultations, :guest
  end
end
