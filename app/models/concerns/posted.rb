module Posted
    extend ActiveSupport::Concern

    included do
        has_paper_trail
    end

    def author
        User.find_by id: originator.to_i
    end

    module ClassMethods
        def default_page_size
            5
        end

        def find_by_author author
            joins(:versions).where('versions.whodunnit' => author.id.to_s)
        end

        def recent
            order_by created_at: :desc
        end
    end
end

