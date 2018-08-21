class PersonsController < ApplicationController
  
  def create
    @person = Person.create(person_params)
    if @person.save
      ReferenceGroup.create(group_id: params['group_id'], reference_id: @person.id)
    else
      @errors = format_errors(@person)
    end
    respond_to do |format|
      format.js
    end
  end

  def update
    @person = Person.find(params['id'])
    if @person.update(person_params)
      render json: @person
    else
      render json: @person.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @person = Person.find(params['id'])
    @person.destroy
    render nothing: true
  end

  private

  def person_params
    params.require(:person).permit(:name, :organization_id, :name, :type, :created_by_id)
  end

end