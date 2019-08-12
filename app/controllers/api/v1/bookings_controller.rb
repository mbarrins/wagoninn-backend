class Api::V1::BookingsController < ApplicationController
  before_action :set_booking, only: [:show]
  
  def show
    render json: @booking, include: [:booking_pens => {include: :booking_pen_pets}]
  end

  def index
    if params[:date_from] && params[:date_to]
      render json: {availability: BookingPen.bookings_by_date(date_from: params[:date_from], date_to: params[:date_to])}
    else
      render json: {errors: ['Date range must be specified']}, status: :not_accepted
    end
  end

  def create
    
    booking = Booking.create_with_all(booking: bookings_params, booking_pens: booking_pens_params[:booking_pens])

    if booking.valid? 
      render json: booking, include: [:booking_pens => {include: :booking_pen_pets}]
    else
      render json: {errors: booking.errors.full_messages}, status: :not_accepted
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def bookings_params
    params.require(:booking).permit(:owner_id, :check_in, :check_in_time, :check_out, :check_out_time, :booking_status_id)
  end

  def booking_pens_params
    params.require(:booking).permit(booking_pens: [:booking_id, :pen_type_id, :pen_id, :rate_id, booking_pen_pets: [:booking_pen_id, :pet_id, :special_needs_fee]])
  end

end
