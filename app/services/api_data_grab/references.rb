module ApiDataGrab
  class References

    def self.run(user)
      all_references = []
      user.organizations.each do |organization|
        organization.references.each do |reference|
          reference_json = ReferenceSerializer.new(reference, root: false).to_json
          all_references << JSON.parse(reference_json)
        end
      end
      all_references
    end

  end
end