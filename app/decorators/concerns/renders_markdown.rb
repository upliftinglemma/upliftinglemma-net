module RendersMarkdown
    extend ActiveSupport::Concern

    def render_markdown content
        markdown.render(body).html_safe
    end

    private

    def markdown
        markdown_options = helpers.policy(self).markdown_options
        renderer_options = markdown_options.extract! :renderer

        renderer = Redcarpet::Render::HTML.new renderer_options
        Redcarpet::Markdown.new renderer, markdown_options
    end
end

