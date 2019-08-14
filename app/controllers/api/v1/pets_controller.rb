class Api::V1::PetsController < ApplicationController
  before_action :set_pet, only: [:show]
  
  def show
    render json: @pet.api_info
  end

  def create
    
    pet = Pet.create_with_all(
        pet: pet_params, 
        immunisations: params[:pet][:immunisations],
        foods: params[:pet][:foods],
        health_details: params[:pet][:health_details],
        special_needs: params[:pet][:special_needs],
        medications: params[:pet][:medications],
        sociabilities: params[:pet][:sociabilities],
        issues: params[:pet][:issues]
      )

    if pet.valid? 
      render json: pet.api_info
    else
      render json: {errors: pet.errors.full_messages}, status: :not_accepted
    end
  end

  private

  def set_pet
    @pet = Pet.find(params[:id])
  end

  def pet_params
    params.require(:pet).permit(:owner_id, :name, :pet_type_id, :dob, :sex_id, :breed_id, :color_id, :size_id, :spayed_neutered)
  end

end
