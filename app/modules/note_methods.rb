module NoteMethods

  def type
    if self.reference_id.nil?
      'Note'
    else
      self.reference.type
    end
  end

  def text_note?
    self.reference_id.nil?
  end
  
end