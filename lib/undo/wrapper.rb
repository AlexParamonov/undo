require "forwardable"

# TODO: extract to a gem
module Undo
  class Wrapper < SimpleDelegator
    def self.configure
      yield config
    end

    def self.config
      @config ||= Configuration.new
    end

    extend Forwardable
    def_delegators :object, :class, :kind_of?

    attr_reader :undo_uuid, :config

    def initialize(object, options)
      @object = object
      @config = Undo::Wrapper.config.with options
      @options = options

      super object
    end

    def method_missing(method, *args, &block)
      store if config.store_on.include? method
      super method, *args, &block
    end

    private
    attr_reader :object, :options

    def store
      @undo_uuid = Undo.store object, options
    end

    # TODO: Virtus
    class Configuration
      attr_accessor :store_on

      def initialize(attributes = {})
        @store_on = attributes.fetch :store_on, [:delete, :destroy]
      end

      def with(attribute_updates = {})
        self.class.new store_on: (attribute_updates.delete(:store_on) || store_on)
      end

    end
  end
end
