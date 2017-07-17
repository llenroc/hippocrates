# frozen_string_literal: true

class ConsultationPresenter < SimpleDelegator
  def date
    created_at.strftime('%F')
  end

  def time
    created_at.strftime('%I:%M %p')
  end

  def pretty_date
    I18n.localize(created_at, format: '%B %d de %Y')
  end
end
