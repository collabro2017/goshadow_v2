class ExperienceDecorator < Draper::Decorator

  delegate_all

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def location
    object.location.present? ? object.location : 'No location specified'
  end

  def description
    object.description.present? ? object.description : 'No description given'
  end

end
