module ArchiveHelper

  def archive
    self.update(archived: true)
  end

end