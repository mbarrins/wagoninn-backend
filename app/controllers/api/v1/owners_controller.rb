class Api::V1::OwnersController < ApplicationController
  before_action :set_owner, only: [:show, :update]
  
  def show
    render json: @owner, include: [:pets, :bookings => {include: [:booking_pens => {include: :booking_pen_pets}]}]
  end

  def create
    owner = Owner.find_or_create_by(owners_params)
    if owner.valid? 
      render json: owner, include: :pets
    else
      render json: {errors: owner.errors.full_messages}, status: :not_accepted
    end
  end

  def index
    
    if params[:q]
      render json: Owner.search(query: params[:q])
    else
      render json: []
    end
  end

  def update
    @owner.update(owners_params)
    if @owner.valid? 
      render json: @owner, include: :pets
    else
      render json: {errors: @owner.errors.full_messages}, status: :not_accepted
    end
  end

  private

  def set_owner
    @owner = Owner.find(params[:id])
  end

  def owners_params
    params.require(:owner).permit(:first_name, :last_name, :email, :primary_phone, :primary_phone_type_id, :secondary_phone, :secondary_phone_type_id, 
      :address_line_1, :address_line_2, :address_line_3, :city, :state, :zipcode, :emergency_contact_name, :emergency_contact_phone, :partner_name, :partner_phone,
      :agreed_terms, :agreed_date, :notes)
  end

end
