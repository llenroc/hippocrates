class PatientsController < ApplicationController
  ATTRIBUTE_WHITELIST = [
    :medical_history,
    :identity_card_number,
    :first_name,
    :last_name,
    :birthdate,
    :gender,
    :civil_status,
    :address,
    :phone_number,
    :source,
    :profession
  ].freeze

  def index
    @patients = Patient.search(params[:last_name], params[:first_name]).page(page)
  end

  def special
    @patients = Patient.special.sort_by do |p|
      p.consultations.most_recent.created_at
    end.reverse
  end

  def new
    @patient = Patient.new
    @patient.medical_history = Setting::MedicalHistorySequence.next
  end

  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      Setting::MedicalHistorySequence.new.save
      # XXX: Pull out the messages form a locale file.
      redirect_to new_patient_anamnesis_path(@patient), notice: 'Paciente creado correctamente'
    else
      render :new
    end
  end

  def edit
    @patient = Patient.find(params[:id])
  end

  def update
    @patient = Patient.find(params[:id])
    if @patient.update_attributes(patient_params)
      redirect_to patients_path, notice: 'Paciente actualizado correctamente'
    else
      render :edit
    end
  end

  private

  def patient_params
    params.require(:patient).permit(*ATTRIBUTE_WHITELIST)
  end
end
