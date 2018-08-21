class GroupsController < ApplicationController

  def create
    @group = Group.create(group_params)
    if !@group.save
      @errors = format_errors(@group)
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @group = Group.find(params['id'])
    Reference.where(group_id: @group.id).update_all(group_id: nil)
    @group.destroy
    render nothing: true
  end

  def add_references
    if params['group_id'].present? && params['reference_ids'].present?
      @group = Group.find(params['group_id'])
      params['reference_ids'].each do |reference_id|
        ReferenceGroup.create(reference_id: reference_id, group_id: params['group_id'])
      end
      render json: "Successfuly added to the '#{@group.name}' group."
    else
      render json: "Could not add to group—select group and #{params['reference_type']}."
    end
  end

  def remove_reference
    @referece_group = ReferenceGroup.find_by(group_id: params['id'], reference_id: params['reference_id'])
    @referece_group.destroy
    render nothing: true
  end

  private

  def group_params
    params.require(:group).permit(:name, :organization_id, :name, :type)
  end

end