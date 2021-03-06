# frozen_string_literal: true

module Rdf2marc
  module Rdf2model
    module Mappers
      # Mapping to Physical Description Fields model.
      class PhysicalDescriptionFields < BaseMapper
        def generate
          {
            physical_descriptions: physical_descriptions,
            media_types: media_types,
            carrier_types: carrier_types,
            content_types: content_types
          }
        end

        private

        def physical_descriptions
          extent_terms = item.instance.query.path_all([[BF.extent, BF.Extent]])
          extent_physical_description = extent_terms.sort.map do |extent_term|
            {
              extents: item.instance.query.path_all_literal([RDF::RDFS.label], subject_term: extent_term).sort,
              # Can be multiple notes, but only using one.
              materials_specified: item.instance.query.path_first_literal([[BF.note, BF.Note],
                                                                           RDF::RDFS.label], subject_term: extent_term)
            }
          end
          dimensions = {
            dimensions: item.instance.query.path_all_literal([BF.dimensions]).sort
          }
          extent_physical_description + [dimensions]
        end

        def media_types
          media_type_terms = item.instance.query.path_all([BF.media])
          media_type_terms.sort.map do |media_type_term|
            {
              media_type_terms: [item.instance.query.path_first_literal([RDF::RDFS.label],
                                                                        subject_term: media_type_term)],
              media_type_codes: [media_type_term.value.sub(%r{^https?://id.loc.gov/vocabulary/mediaTypes/}, '')],
              authority_control_number_uri: media_type_term.value
            }
          end
        end

        def carrier_types
          carrier_type_terms = item.instance.query.path_all([BF.carrier])
          carrier_type_terms.sort.map do |carrier_type_term|
            {
              carrier_type_terms: [item.instance.query.path_first_literal([RDF::RDFS.label],
                                                                          subject_term: carrier_type_term)],
              carrier_type_codes: [carrier_type_term.value.sub(%r{^https?://id.loc.gov/vocabulary/carriers/}, '')],
              authority_control_number_uri: carrier_type_term.value
            }
          end
        end

        def content_types
          content_type_terms = item.work.query.path_all([BF.content])
          content_type_terms.sort.map do |content_type_term|
            {
              content_type_terms: [item.work.query.path_first_literal([RDF::RDFS.label],
                                                                      subject_term: content_type_term)],
              content_type_codes: [content_type_term.value.sub(%r{^https?://id.loc.gov/vocabulary/contentTypes/}, '')],
              authority_control_number_uri: content_type_term.value
            }
          end
        end
      end
    end
  end
end
