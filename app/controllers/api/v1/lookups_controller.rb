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
      dose: Dose.all,
      food: Food.all,
      measure: Measure.all,
      personType: PersonType.all,
      phoneType: PhoneType.all,
      roomType: RoomType.all,
      bookingStatus: BookingStatus.all,
      validity: Validity.all,
      specialNeeds: SpecialNeed.api_info,
      sociability: Sociability.api_info,
      schedule: Schedule.api_info,
      issues: Issue.api_info,
      concerns: Concern.api_info,
      penType: PenType.all

    }}
  end
end
