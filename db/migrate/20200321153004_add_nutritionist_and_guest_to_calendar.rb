class AddNutritionistAndGuestToCalendar < ActiveRecord::Migration[5.2]
  def change
    add_reference :calendars, :nutritionist
    add_reference :calendars, :guest
  end
end
