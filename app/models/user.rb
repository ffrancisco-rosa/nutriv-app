class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :nutritionist_consultations, class_name: 'consultations', foreign_key: 'nutritionist_id'
  has_many :guest_consultations, class_name: 'consultations', foreign_key: 'guest_id'

  has_many :nutritionist_tasks, class_name: 'tasks', foreign_key: 'nutritionist_id'

  # has_many :nutritionist_consultations_spots, class_name: 'consultations_spots', foreign_key: 'nutritionist_id'
  # has_many :guest_consultations_spots, class_name: 'consultations_spots', foreign_key: 'guest_id'

  has_one :nutritionist_calendar, class_name: 'calendar', foreign_key: 'nutritionist_id'
  has_one :guest_calendar, class_name: 'calendar', foreign_key: 'guest_id'
  has_many :consultations_spots

  has_one_attached :avatar

  devise :omniauthable, :omniauth_providers => [:google_oauth2]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [ :guest, :nutritionist ]


  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data["email"]).first

    unless user
      user = User.create!(
            email: data["email"],
            password: Devise.friendly_token[0,20]
      )
    end
    user
  end

  def expired?
    if expires_at == nil
      return true
    else
      expires_at < Time.current.to_i
    end
  end
end
