# frozen_string_literal: true

module Rdf2marc
  module Model2marc
    # Maps model to field 610.
    class Field610 < Field
      def initialize(marc_record, model)
        super(marc_record, model, '610')
      end

      def build
        field.indicator1 = name_type
        append('a', model.corporate_name)
        append('b', model.subordinate_unit)
        append_repeatable('c', model.meeting_location)
        append('d', model.meeting_date)
        append_repeatable('e', model.relator_terms)
        append('f', model.work_date)
        append_repeatable('g', model.misc_infos)
        append_repeatable('h', model.versions)
        append_repeatable('k', model.form_subheadings)
        append('l', model.work_language)
        append_repeatable('m', model.music_performance_mediums)
        append_repeatable('n', model.part_numbers)
        append_repeatable('o', model.music_arranged_statement)
        append_repeatable('p', model.part_names)
        append('r', model.music_key)
        append('s', model.medium)
        append('t', model.work_title)
        append('u', model.affiliation)
        append_repeatable('v', model.form_subdivisions)
        append_repeatable('x', model.general_subdivisions)
        append_repeatable('y', model.chronological_subdivisions)
        append_repeatable('z', model.geographic_subdivisions)
        append_repeatable('0', model.authority_record_control_number)
        append('1', model.uri)
        append('2', model.heading_source)
        append('3', model.materials_specified)
        append_repeatable('4', model.relationship)
        append('6', model.linkage)
        append_repeatable('8', model.field_link)
      end

      private

      def name_type
        case model.type
        when 'inverted'
          '0'
        when 'jurisdiction'
          '1'
        else
          '2'
        end
      end
    end
  end
end