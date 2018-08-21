class PlaceGroupsController < ApplicationController

  def update
    @place_group = PlaceGroup.find(params['id'])
    if @place_group.update(place_group_params)
      render json: @place_group
    else
      render json: @place_group.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def place_group_params
    params.require(:place_group).permit(:name, :organization_id, :name, :type)
  end

end