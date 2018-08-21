class PlacesController < ApplicationController

  def create
    @place = Place.create(place_params)
    if @place.save
      ReferenceGroup.create(group_id: params['group_id'], reference_id: @place.id)
    else
      @errors = format_errors(@place)
    end
  end

  def update
    @place = Place.find(params['id'])
    if @place.update(place_params)
      render json: @place
    else
      render json: @place.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @place = Place.find(params['id'])
    @place.destroy
    render nothing: true
  end

  private 

  def place_params
    params.require(:place).permit(:name, :organization_id, :name, :type, :created_by_id)
  end

end