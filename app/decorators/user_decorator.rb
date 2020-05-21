class UserDecorator < Draper::Decorator
  delegate_all

  include Rails.application.routes.url_helpers

  def avatar_or_default(size = 400)
    if user.avatar.attached?
      variant = user.avatar.variant(resize: "#{size}x#{size}").processed
      rails_representation_url(variant)
    else
      GravatarImageTag.gravatar_url(email, size: size)
    end
  end
end
