require "json"

module Undo
  module Serializer
    class Simple
      def to_json(object)
        object.to_json
      end

      def from_json(json)
        JSON.parse json
      end

      def to_xml(object)
        raise NotImplementedError
      end

      def from_xml(xml)
        raise NotImplementedError
      end
    end
  end
end
