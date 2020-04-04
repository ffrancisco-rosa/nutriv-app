require "google/apis/calendar_v3"
require "google/api_client/client_secrets.rb"
require "pry-byebug"

module Nutritionist
  class TasksController < ApplicationController
    CALENDAR_ID = 'primary'
    def index
      @tasks = policy_scope([:nutritionist, Task])
    end

    def new
      @task = Task.new
      @consultation_spots = ConsultationSpot.where(nutritionist_id: current_user)
      authorize [:nutritionist, @task]
    end

    def create

      @task = Task.new(task_params)
      @task.nutritionist_id = current_user.id

      @task.save!
      user = current_user
      client = get_google_calendar_client user
      event = get_event(@task)

      event = Google::Apis::CalendarV3::Event.new(event)

      if client.insert_event(CALENDAR_ID, event)
        redirect_to nutritionist_tasks_path, notice: "Task created"
      else
        redirect_to new_nutritionist_task_path, notice: "not created"
      end
    end

    def edit(task, user)
      client = get_google_calendar_client user
      event = get_event task
      event = Google::Apis::CalendarV3::Event.new(event)
      client.update_event(CALENDAR_ID, event.id, event)
    end

    def delete(event_id, user)
      client = get_google_calendar_client user
      client.delete_event(CALENDAR_ID, event_id)
    end

    def get(event_id, user)
      client = get_google_calendar_client user
      client.get_event(CALENDAR_ID, event_id)
    end

    private

    def get_event(task)
      # in case many attendes... need to figure this out
      # using the split bugs it.
      # attendees = task.members.split(',')

      event = {
        summary: task.title,
        description: task.description,
        start: {
          date_time: @task.start_date.to_datetime.rfc3339,
          time_zone: "Europe/Lisbon"
        },
        end:{
          date_time: @task.end_date.to_datetime.rfc3339,
          time_zone: "Europe/Lisbon"
        },
        sendNotifications: true,
        attendees: [ { email: task.members },
        ],
        reminders: {
          use_default: true
        },
        color_id: ConsultationSpot.find(task.consultation_spot_id).color.to_s
      }

       # event[:id] = task.event if task.event

      event
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

          # if current_user.expired?
          #   client.authorization.refresh!
          #   current_user.update_attributes(
          #     access_token: client.authorization.access_token,
          #     refresh_token: client.authorization.refresh_token,
          #     expires_at: client.authorization.expires_at.to_i
          #   )
          # end
        rescue => e
          raise e.message
        end
        client
    end

    def task_params
      params.require(:task).permit(:title, :description, :start_date, :end_date, :event, :members, :nutritionist_id, :consultation_spot_id)
    end
  end
end
