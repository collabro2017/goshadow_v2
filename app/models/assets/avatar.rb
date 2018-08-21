class Avatar < Asset

  has_attached_file :attachment,
  path: '/avatar/:id/:style/:filename',
  bucket: ENV['S3_BUCKET'],
  styles: { small: '45x45#', medium: '120x120#', large: '400x400#'}

  validates_attachment_content_type :attachment, content_type: /\Aimage\/.*\Z/
  
end