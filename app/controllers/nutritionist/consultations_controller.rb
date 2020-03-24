require "google/apis/calendar_v3"
require "google/api_client/client_secrets.rb"

module Nutritionist
  class ConsultationsController < ApplicationController
    before_action :find, only: [:show]
    def index
      @consultations = policy_scope([:nutritionist, Consultation])
    end

    def show
      authorize [:nutritionist, @consultation]
    end

    def new
      @consultation = Consultation.new
      @nutritionist = current_user

      authorize [:nutritionist, @consultation]
    end

    def create
      @consultation = Consuultation.new
      client = get_google_calendar_client current_user
      consultation = params[:consultation]
      event = get_event consultation
      client.insert_event('primary', event)
      flash[:notice] = 'Consultation was successfully added.'
      redirect_to nutrionist_consultations_path
    end

    def get_google_calendar_client current_user
      client = Google::Apis::CalendarV3::CalendarService.new
      return unless (current_user.present? && current_user.access_token.present? && current_user.refresh_token.present?)
      secrets = Google::APIClient::ClientSecrets.new({
        "web" => {
          "access_token" => current_user.access_token,
          "refresh_token" => current_user.refresh_token,
          "client_id" => ENV["GOOGLE_API_KEY"],
          "client_secret" => ENV["GOOGLE_API_SECRET"]
        }
      })
      begin
        client.authorization = secrets.to_authorization
        client.authorization.grant_type = "refresh_token"

        if !current_user.present?
          client.authorization.refresh!
          current_user.update_attributes(
            access_token: client.authorization.access_token,
            refresh_token: client.authorization.refresh_token,
            expires_at: client.authorization.expires_at.to_i
          )
        end
      rescue => e
        flash[:error] = 'Your token has been expired. Please login again with google.'
        redirect_to :back
      end
      client
    end

    private

    def find
      @consultation = Consultation.find(params[:id])
      authorize  [:nutritionist, @consultation]
    end

    def create_params
      params.require(:consultation).permit(:date, :nutritionist_id, :guest_id)
    end

    def edit_params
      params.require(:consultation).permit(:date, :status)
    end

    def get_event consultation
    attendees = consultation[:members].split(',').map{ |t| {email: t.strip} }
    event = Google::Apis::CalendarV3::Event.new({
      summary: consultation[:date],
      location: "Localização: #{ConsultationSpot.find(consultation[:consultation_spot_id])}.",
      description: "Consulta com: #{user.find(consultation[:guest_id]).name}.",
      start: {
        date_time: Time.new(consultation['start_date(1i)'],consultation['start_date(2i)'],consultation['start_date(3i)'],consultation['start_date(4i)'],consultation['start_date(5i)']).to_datetime.rfc3339,
        time_zone: "Europe/Lisbon"
      },
      end: {
        date_time: Time.new(consultation['end_date(1i)'],consultation['<end_date></end_date>(2i)'],consultation['end_date(3i)'],consultation['end_date(4i)'],consultation['end_date(5i)']).to_datetime.rfc3339,
        time_zone: "Europe/Lisbon"
      },
      # attendees: attendees,
      reminders: {
        use_default: false,
        overrides: [
          Google::Apis::CalendarV3::EventReminder.new(reminder_method:"popup", minutes: 10),
          Google::Apis::CalendarV3::EventReminder.new(reminder_method:"email", minutes: 20)
        ]
      },
      notification_settings: {
        notifications: [
                        {type: 'event_creation', method: 'email'},
                        {type: 'event_change', method: 'email'},
                        {type: 'event_cancellation', method: 'email'},
                        {type: 'event_response', method: 'email'}
                       ]
      }, 'primary': true
    })
  end
  end
end
