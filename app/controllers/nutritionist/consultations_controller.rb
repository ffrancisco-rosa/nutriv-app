module Nutritionist
  class ConsultationController < ApplicationController
    before_action :find, only: [:show]
    def index
      @consultations = Consultation.all
      authorize  [:nutritionist, @consultations]
    end

    def show
      authorize [:nutritionist, @consultation]
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
  end
end
