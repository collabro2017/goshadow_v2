class SegmentsController < ApplicationController

  layout 'organization'
  
  def index
    @experience = Experience.find(params['experience_id']).decorate
    @organization = @experience.organization
    @new_segment = @experience.segments.build
    @segments = current_user.accessible_segments(@experience, is_coordinator)
    respond_to do |format|
      format.js
    end
  end
  
  def create
    @experience = Experience.find(params['experience_id'])
    @segment = @experience.segments.build(segment_params)
    if @segment.save
      current_user.add_to_segment(@segment)
      flash['notice'] = 'Your segment has been created! Next, add shadowers, people, and places to your new segment.'
      render nothing: true
    else
      render json: { errors: format_errors(@segment) }, status: :unprocessable_entity
    end
  end

  def update
    @segment = Segment.find(params['id'])
    @segment.update(segment_params)
    if @segment.save
      render nothing: true
    else
      render json: { errors: format_errors(@segment) }, status: :unprocessable_entity
    end
  end

  def destroy
    @segment = Segment.find(params['id'])
    @segment.archive
    render nothing: true
  end

  def persons
    @organization = current_org
    @segment = Segment.find(params['id'])
    @groups = @organization.person_groups
    @persons = @segment.references.where(type: 'Person')
    @references = @organization.persons.where.not(id: @persons.pluck(:id))
    respond_to do |format|
      format.js
    end
  end

  def places
    @organization = current_org
    @segment = Segment.find(params['id'])
    @groups = @organization.place_groups
    @places = @segment.references.where(type: 'Place')
    @references = @organization.places.where.not(id: @places.pluck(:id))
    respond_to do |format|
      format.js
    end
  end

  def shadowers
    @organization = current_org
    @segment = Segment.find(params['id'])
    @shadowers = (org_coordinators + @segment.users ).uniq
    @new_user_segments = @segment.init_user_segments(@organization)
    @invites = @segment.invites
    @invite = Invite.new
    respond_to do |format|
      format.js
    end
  end

  def clone
    @segment = Segment.find(params['id'])
    @experience = @segment.experience
    segment_cloner = SegmentCloner.new(@segment)
    segment_cloner.run
    flash['notice'] = "#{@segment.name} cloned successfully."
    redirect_to experience_path(@experience, tab: 'segments')
  end

  def create_reference
    @segment = Segment.find_by(params['segment_id'])
    @reference = Reference.new(organization_id: params['organization_id'], type: params['reference_type'], name: params['name'], created_by_id: current_user.id)
    if @reference.save
      @sent_from_notes = params['sent_from_notes']
      ReferenceSegment.create(reference_id: @reference.id, segment_id: @segment.id)
    else
      @error = "There is already a #{params['reference_type']} named '#{params['name']}' for your organization."
    end
    respond_to do |format|
      format.js
    end
  end

  def bulk_add_existing_references
    @segment = Segment.find(params['id'])
    @reference_segment_linker = ReferenceSegmentLinker.new(@segment, params['group_ids'], params['reference_ids'])
    @newly_added_references = @reference_segment_linker.run
    respond_to do |format|
      format.js
    end
  end

  def remove_reference
    @reference_segment = ReferenceSegment.find_by(segment_id: params['id'], reference_id: params['reference_id'])
    @reference_segment.destroy
    render nothing: true
  end

  def remove_shadower
    @user_segment = UserSegment.find_by(user_id: params['user_id'], segment_id: params['segment_id'])
    @user_segment.destroy
    render nothing: true
  end

  def update_segment_order
    params['segment_order'].each_with_index do |segment|
      Segment.find(segment[1]['id']).update(sort_order: segment[1]['order'])
    end
    render nothing: true
  end

  private

  def segment_params
    params.require(:segment).permit(:name, :start_location, :end_location, :created_by_id, user_segments_attributes: [
        :id, :user_id, :segment_id
      ]
    )
  end

end