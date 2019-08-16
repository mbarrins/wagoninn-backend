class Api::V1::BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :update]
  skip_before_action :authorize, only: [:index]
  
  def show
    render json: @booking, include: [:booking_pens => {include: :booking_pen_pets}]
  end

  def index
    if params[:date_from] && params[:date_to]
      render json: {dates: BookingPen.bookings_by_date(date_from: params[:date_from], date_to: params[:date_to]), pens_available: PenType.all.map{|type| {pen_type_id: type.id, pens_available: BookingPen.available_all(check_in: params[:date_from], check_out: params[:date_to], pen_type_id: type.id)}}}
    elsif params[:detail]
      render json: Booking.daily_detail(date: params[:detail])
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

  def update
    @booking.update_with_all(booking: bookings_params, booking_pens: booking_pens_params[:booking_pens])

    if @booking.valid? 
      render json: @booking, include: [:booking_pens => {include: :booking_pen_pets}]
    else
      render json: {errors: @booking.errors.full_messages}, status: :not_accepted
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def bookings_params
    params.require(:booking).permit(:id, :owner_id, :check_in, :check_in_time, :check_out, :check_out_time, :booking_status_id)
  end

  def booking_pens_params
    params.require(:booking).permit(booking_pens: [:id, :booking_id, :pen_type_id, :pen_id, :rate_id, booking_pen_pets: [:id, :booking_pen_id, :pet_id, :special_needs_fee]])
  end

end
