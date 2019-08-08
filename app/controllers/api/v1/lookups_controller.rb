class Api::V1::LookupsController < ApplicationController
  skip_before_action :authorize, only: [:index]

  def index
    render json: {lookups: {
      colors: Color.all, 
      breeds: Breed.api_info, 
      sexes: Sex.all, 
      sizes: Size.all, 
      petTypes: PetType.all,
      immunisations: Immunisation.api_info,
      healthDetails: HealthDetail.all,
      medications: Medication.all,
      doses: Dose.all,
      foods: Food.all,
      measures: Measure.all,
      phoneTypes: PhoneType.all,
      roomTypes: RoomType.all,
      bookingStatuses: BookingStatus.all,
      validity: Validity.all,
      specialNeeds: SpecialNeed.api_info,
      sociabilities: Sociability.api_info,
      schedules: Schedule.api_info,
      issues: Issue.api_info,
      concerns: Concern.api_info,
      penTypes: PenType.all
      }
    }
  end
end
