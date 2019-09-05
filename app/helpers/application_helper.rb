module ApplicationHelper
  def avatar_url(user)
    if user.image.attached?
      url_for(user.image)
    elsif user.image?
      user.image
    else
      ActionController::Base.helpers.asset_path('avatar.jpg')
    end
  end
end
