module Nutritionist
  class ConsultationSpotsController < ApplicationController
    before_action :find, only: [:show]
    def index
      @consultation_spots = ConsultationSpot.all
      authorize  [:nutritionist, @consultation_spots]
    end

    def new
      ConsultationSpot.new
    end

    def create

    end

    private

    def find
      @consultation_spot = ConsultationSpot.find(params[:id])
      authorize  [:nutritionist, @consultation_spot]
    end

    def create_params
      params.require(:consultation).permit(:name, :address)
    end
  end
end
