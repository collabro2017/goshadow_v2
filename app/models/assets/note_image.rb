class NoteImage < Asset

  has_attached_file :attachment,
  path: '/note_image/:id/:style/:filename',
  bucket: ENV['S3_BUCKET']

  validates_attachment :attachment, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

end