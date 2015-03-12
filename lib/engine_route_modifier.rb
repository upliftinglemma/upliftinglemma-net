class EngineRouteModifier < SimpleDelegator
    def initialize obj, **options
        super obj
        @options = options
    end

    def method_missing method, *args, **kwargs, &block
        super method, *args, **kwargs, **@options, &block
    end
end

