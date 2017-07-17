require 'rails_helper'

describe ConsultationPresenter do
  describe '#date' do
    it 'returns the consultation date' do
      consultation = double(:consultation, created_at: DateTime.new(2016, 1, 15))
      presenter = described_class.new(consultation)
      expect(presenter.date).to eq('2016-01-15')
    end
  end

  describe '#time' do
    it 'returns the consultation time' do
      consultation = double(:consultation,
                            created_at: DateTime.new(2016, 1, 15, 11, 15, 0))
      presenter = described_class.new(consultation)
      expect(presenter.time).to eq('11:15 AM')
    end
  end

  describe '#pretty_date' do
    it 'returns the formatted consultation date' do
      consultation = double(:consultation, created_at: DateTime.new(2016, 4, 13))
      presenter = described_class.new(consultation)
      expect(presenter.pretty_date).to eq('Abril 13 de 2016')
    end
  end
end
