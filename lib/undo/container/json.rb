require 'json'

module Undo
  module Container
    class Json
      def pack(object)
        object.to_json
      end

      def unpack(json)
        JSON.load json
      end
    end
  end
end
