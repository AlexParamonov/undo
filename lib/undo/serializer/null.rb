module Undo
  module Serializer
    class Null
      def serialize(object, options = {})
        object
      end

      def deserialize(object, options = {})
        object
      end
    end
  end
end
