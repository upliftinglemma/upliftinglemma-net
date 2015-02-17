module ApplicationHelper
    def content_or_default_for(name, default=nil)
        if content_for?(name)
            content_for(name)
        else
            default
        end
    end
end
