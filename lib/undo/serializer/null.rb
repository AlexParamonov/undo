module Undo
  module Serializer
    class Null
      def serialize(object)
        object
      end

      def deserialize(object)
        object
      end
    end
  end
end
