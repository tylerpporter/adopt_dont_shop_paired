class PetDecorator < SimpleDelegator
  include ActionView::Helpers::UrlHelper

  def display_adopt_link
    if(status == "Adoptable")
      link_to("Change to Adoption Pending", "/pets/#{id}?status=pending", method: :patch)
    else
      link_to("Change to Adoptable", "/pets/#{id}?status=adoptable", method: :patch)
    end
  end

  def display_notes
    notes.present? ? (link_to "#{notes}", "/apps/#{approved_applicant}") : ("#{notes}")
  end

end