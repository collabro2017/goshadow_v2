class NotesController < ApplicationController

  def index
    @segment = Segment.find(params['segment_id'])
    @notes = @segment.notes
    @persons = current_org.persons
    @places = current_org.places
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @note = Note.find(params['id'])
    @note.destroy
    render nothing: true
  end

  def create
    @segment = Segment.find(params['note']['segment_id'])
    respond_to do |format|
      if params['note']['text'].present?
        create_note
        @notes = @segment.notes
        format.js
      else
        format.js
        @error = 'Must add text to create a note.'
      end
    end
  end

  def create_person_place
    @segment = Segment.find(params['note']['segment_id'])
    respond_to do |format|
      params['note']['seconds'] = params['note']['seconds'].to_i
      if params['note']['reference_id'].present?
        create_note
        @notes = @segment.notes
        format.js { render 'create.js.erb' }
      else
        format.js { render 'create.js.erb' }
        @error = "Must select #{params['type']} from the dropdown."
      end
    end
  end

  def update
    @note = Note.find(params['id'])
    if @note.update(note_params)
      respond_to do |format|
        format.json { respond_with_bip(@note) }
      end
    else
      render json: @note.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update_status
    @note = Note.find(params['note_id'])
    @note.update(status: params['status'])
    render nothing: true
  end

  private

  def create_note
    @note = Note.create(note_params)
    @note.update(created_at: @note.created_at + 4.hours)
  end

  def note_params
    params.require(:note).permit(:start_time, :text, :seconds, :status, :user_id, :reference_id, :segment_id, :created_at, :updated_at)
  end

end