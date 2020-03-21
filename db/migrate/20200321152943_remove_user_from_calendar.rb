class RemoveUserFromCalendar < ActiveRecord::Migration[5.2]
  def change
    remove_reference :calendars, :user
  end
end
