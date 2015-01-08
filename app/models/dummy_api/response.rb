require 'active_support/inflector'
require 'ffaker'

module DummyApi
  class Response
    attr_reader :settings
    def initialize(settings)
      @settings = settings
    end

    def to_hash
      @to_hash ||= generate_hash
    end

    private

    def generate_hash
      {}.tap do |hash|
        settings[:data].each do |key, options|
          hash[key] = rows(options[:fields])
        end

        hash[:page] = settings[:page]
        hash[:per_page] = settings[:per_page]
        hash[:total] = settings[:total]
      end
    end

    def rows(fields)
      Array.new([]).tap do |rows|
        page_rows_count.times do
          row = Hash[
            fields.map do |hash|
              [hash.keys.first, field_to_value(hash.values.first)]
            end
          ]
          rows << row
        end
      end
    end

    def field_to_value(field)
      [
        'DummyApi',
        'Fields',
        field.capitalize
      ].join('::').constantize.new.value
    end

    def per_page
      settings[:per_page]
    end

    def total
      settings[:total]
    end

    def page
      settings[:page]
    end

    def page_rows_count
      [total - previous_rows_count, per_page].min
    end

    def previous_rows_count
      [(page * per_page - per_page), 0].max
    end
  end
end

require_relative 'field'
require_relative 'fields/name'
require_relative 'fields/email'
