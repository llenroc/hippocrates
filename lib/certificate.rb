class Certificate
  def self.for(consultation, options = {})
    new(consultation, options).build
  end

  def initialize(consultation, options)
    @consultation = consultation
    @options = options
  end

  # rubocop:disable MethodLength
  # rubocop:disable Metrics/AbcSize
  def build
    {
      patient: patient,
      consultation: consultation,
      diagnosis: diagnosis,
      definite_article: definite_article,
      current_date: current_date,
      start_time: options.fetch(:start_time, ''),
      end_time: options.fetch(:end_time, ''),
      rest_time: options.fetch(:rest_time, ''),
      surgical_treatment: options.fetch(:surgical_treatment, '').upcase,
      surgery_tentative_date: options.fetch(:surgery_tentative_date, '').upcase,
      surgery_cost: options.fetch(:surgery_cost, ''),
      consultations: consultations
    }
  end

  private

  attr_reader :consultation, :options

  def patient
    consultation.patient
  end

  def diagnosis
    consultation.diagnoses.first
  end

  def definite_article
    patient.male? ? 'el' : 'la'
  end

  def current_date
    I18n.localize(Date.today, format: :long)
  end

  def consultations
    selected_consultations_ids = options.fetch(:consultations, '').split('_').map(&:to_i)
    patient_consultations = patient.consultations.reverse

    selected_consultations = patient_consultations.select do |c|
      selected_consultations_ids.include? c.id
    end

    first_consultation_id = patient_consultations.first.id
    selected_consultations.each { |c| c.head = c.id == first_consultation_id }
  end
end
