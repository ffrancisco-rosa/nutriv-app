class Task < ApplicationRecord
  belongs_to :nutritionist, class_name: "User"
end
