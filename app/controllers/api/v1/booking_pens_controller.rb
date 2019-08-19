class Api::V1::BookingPensController < ApplicationController
  before_action :set_booking_pen, only: [:update]

  def update
    @booking_pen.update(booking_pens_params)

    if @booking_pen.valid? 
      render json: @booking_pen, status: :accepted
    else
      render json: {errors: @booking_pen.errors.full_messages}, status: :not_accepted
    end
  end

  private

  def set_booking_pen
    @booking_pen = BookingPen.find(params[:id])
  end

  def booking_pens_params
    params.require(:booking_pen).permit(:pen_id)
  end

end
