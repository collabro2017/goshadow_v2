class PersonGroupsController < ApplicationController

  def update
    @person_group = PersonGroup.find(params['id'])
    if @person_group.update(person_group_params)
      render json: @person_group
    else
      render json: @person_group.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def person_group_params
    params.require(:person_group).permit(:name, :organization_id, :name, :type)
  end

end