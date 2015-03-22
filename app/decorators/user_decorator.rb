class UserDecorator < ApplicationDecorator
    delegate_all

    def avatar size: 50
        helpers.gravatar_image_tag email,
            alt: name,
            class: 'img-rounded',
            gravatar: {
                default: :identicon,
                size: size
            }
    end
end

