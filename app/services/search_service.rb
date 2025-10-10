# frozen_string_literal: true

class SearchService
  def initialize(model)
    @model = model
  end

  def search(search)
    if search.present?
    @model.where(title: /#{Regexp.escape(search)}/i)
    else
      @model.all
    end
  end
end