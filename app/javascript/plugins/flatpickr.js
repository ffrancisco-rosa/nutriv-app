import flatpickr from "flatpickr"
import "flatpickr/dist/flatpickr.min.css" // Note this is important!

flatpickr(".datepicker", {
  altInput: true,
  allowInput: true,
  minDate: "today",
  enableTime: true,

  "disable": [
    function(date) {
    // return true to disable
      return (date.getDay() === 0);
      }
    ],
    "locale": {
        "firstDayOfWeek": 1 // start week on Monday
    }
})
