require 'date'

module Icalendar
  module Values

    class DateTime < Value
      FORMAT = '%Y%m%dT%H%M%S'

      def initialize(value, params = {}, include_value_param = false)
        # TODO deal with timezones
        if value.respond_to? :to_datetime
          super value.to_datetime, params, include_value_param
        elsif value.is_a? String
          super ::DateTime.strptime(value, FORMAT), params, include_value_param
        else
          super
        end
      end

      def value_ical
        if offset == 0 && ical_params['tzid'].nil?
          "#{strftime FORMAT}Z"
        else
          strftime FORMAT
        end
      end

    end

  end
end