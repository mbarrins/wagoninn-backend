class Api::V1::OwnersController < ApplicationController
  skip_before_action :authorize, only: [:show]

  before_action :set_owner, only: [:show]
  
  def show
    render json: @owner, include: :pets
  end

  def create
    owner = Owner.find_or_create_by(owners_params)
    if owner.valid? 
      render json: owner, include: :pets
    else
      render json: {errors: owner.errors.full_messages}, status: :not_accepted
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

  def owners_pet_params
    params.require(:owner).permit({pets: [:owner_id, :pet_type_id, :name, :dob, :sex_id, :color_id, :size_id, :breed_id, :spayed_neutered, :notes, :special_needs_fee, :no_return, :inactive]})
  end
end
