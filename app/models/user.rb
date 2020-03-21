class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :nutritionist_consultations, class_name: 'consultations', foreign_key: 'nutritionist_id'
  has_many :guest_consultations, class_name: 'consultations', foreign_key: 'guest_id'

  # has_many :nutritionist_consultations_spots, class_name: 'consultations_spots', foreign_key: 'nutritionist_id'
  # has_many :guest_consultations_spots, class_name: 'consultations_spots', foreign_key: 'guest_id'

  has_one :nutritionist_calendar, class_name: 'calendar', foreign_key: 'nutritionist_id'
  has_one :guest_calendar, class_name: 'calendar', foreign_key: 'guest_id'
  has_many :consultations_spots

  has_one_attached :avatar

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [ :guest, :nutritionist ]
end
