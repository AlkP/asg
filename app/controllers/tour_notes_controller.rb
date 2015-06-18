class TourNotesController < ApplicationController
  def create
    tour_note = TourNote.create(tour_notes_params)
    tour_note.save
    @tour_notes = TourNote.all_alkp.where('tour_id = ?', tour_note.tour_id)
  end
  def destroy
    tour_note = TourNote.find(params[:id])
    tour_id = tour_note.tour_id
    TourNote.destroy tour_note
    @tour_notes = TourNote.all_alkp.where('tour_id = ?', tour_id)
  end
  private
  def tour_notes_params
    params.require(:tour_note).permit( :name,
                                       :tour_id )
  end
end
