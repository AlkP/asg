class StaffNotesController < ApplicationController
  def create
    note = StaffNote.create(notes_params)
    note.save
    @staff_notes = StaffNote.all_alkp.where('staff_id = ?', params[:staff_note][:staff_id])
    respond_to do |format|
      format.js
      format.html
    end
  end
  def destroy
    staff_note = StaffNote.find(params[:id])
    @staff_notes = StaffNote.all_alkp.where('staff_id = ?', staff_note.staff_id)
    #staff_note.destroy
    StaffNote.destroy staff_note
    respond_to do |format|
      format.js
      format.html
    end
  end
  private
  def notes_params
    params.require(:staff_note).permit( :name, :description, :staff_id )
  end
end
