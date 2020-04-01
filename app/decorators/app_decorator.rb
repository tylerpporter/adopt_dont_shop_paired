class AppDecorator < SimpleDelegator

  def display_button
    pets.any? { |pet| pet.notes == nil }
  end

end