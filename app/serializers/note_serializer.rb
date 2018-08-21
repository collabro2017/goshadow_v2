class NoteSerializer < ActiveModel::Serializer

  attributes :id, :reference_id, :text, :start_time, :seconds, :created_at, :segment_id, :status, :updated_at, :file_url, :user_id

  def reference_name
    object.reference.name
  end

  def reference_type
    object.reference.type
  end

  def file_url
    object.note_image.attachment.url rescue ''
  end

end