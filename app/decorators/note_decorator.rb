class NoteDecorator < Draper::Decorator

  delegate_all

  def start_time
    object.start_time.strftime("%_m:%M%p") 
  end

  def note_text    
    text ? text : ''
  end

end