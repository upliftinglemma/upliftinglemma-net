class EngineRouteModifier < SimpleDelegator
    def initialize obj, **options
        super obj
        @options = options
    end

    def method_missing method, *args, &block
        super method, *args, **@options, &block
    end
end

