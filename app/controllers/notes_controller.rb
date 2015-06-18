class NotesController < ApplicationController
  def create
    note = Note.create(notes_params)
    note.save
    @notes = Note.all_alkp.where('client_id = ?', params[:note][:client_id])
    respond_to do |format|
      format.js
      format.html
    end
  end
  def destroy
    note = Note.find(params[:id])
    @notes = Note.all_alkp.where('client_id = ?', note.client_id)
    #note.destroy
    Note.destroy note
    respond_to do |format|
      format.js
      format.html
    end
    #redirect_to users_path
  end
  private
  def notes_params
    params.require(:note).permit( :name, :description, :client_id )
  end
end
