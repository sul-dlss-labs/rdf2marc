# frozen_string_literal: true

module Rdf2marc
  module Rdf2model
    module Mappers
      # Mapping to Note Fields model.
      class NoteFields < BaseMapper
        def generate
          {
            general_notes: general_notes
          }
        end

        private

        def general_notes
          notes = item.instance.query.path_all_literal([[BF.note, BF.Note], RDF::RDFS.label]) +
                  item.work.query.path_all_literal([[BF.note, BF.Note], RDF::RDFS.label])
          notes.sort.map do |note|
            {
              general_note: note
            }
          end
        end
      end
    end
  end
end
