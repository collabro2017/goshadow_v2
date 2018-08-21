class SegmentSorter

  def self.run(segments)
    segments.where.not(sort_order: nil) + segments.where(sort_order: nil)
  end

end