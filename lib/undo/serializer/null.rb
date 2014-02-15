module Undo
  module Serializer
    class Null
      def method_missing(method, object, *args)
        object
      end

      def to_json(object)
        object
      end
    end
  end
end
