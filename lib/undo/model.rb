module Undo
  class Model < SimpleDelegator
    def self.restore(uuid)

    end

    def initialize(object)
      @object = object
      super object
    end

    def uuid
      @uuid ||= object.try(:uuid) || generate_uuid
    end

    private
    attr_reader :object

    def generate_uuid
      SecureRandom.uuid
    end
  end
end
