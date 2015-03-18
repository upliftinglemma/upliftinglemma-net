module Blog
    class ArticlePolicy < ::ApplicationPolicy
        def index?
            true
        end

        def show?
            true
        end

        def create?
            user.present? and user.has_role_for 'writer', app
        end

        def update?
            create? and owner?
        end

        def destroy?
            update?
        end


        def owner?
            user.present? and model.author == user
        end

        def permitted_attributes
            [:title, :tagline, :body]
        end

        def markdown_options
            {
                renderer: {
                    no_styles: true,
                    safe_links_only: true,
                    with_toc_data: true
                },
                autolink: true,
                strikethrough: true,
                underline: true,
                footnotes: true
            }
        end
    end
end

