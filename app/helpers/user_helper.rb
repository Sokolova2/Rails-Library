# frozen_string_literal: true

module UserHelper
  def avatar_image(user, options = { size: 50 })
    size = options[:size]
    if user.avatar.present?
      image_tag user.avatar.url, size: size, class: 'rounded-circle'
    else
      user_gender(user)
    end
  end

  def user_gender(user)
    if user.gender == 'male'
      images = Dir.glob(Rails.root.join('app', 'assets', 'images', 'male', '*'))
      random_photo = File.basename(images.sample)
      user.update(avatar: random_photo)
    elsif user.gender == 'female'
      images = Dir.glob(Rails.root.join('app', 'assets', 'images', 'female', '*'))
      random_photo = File.basename(images.sample)
      user.update(avatar: random_photo)
    else
      image_tag 'avatar.png', class: 'rounded-circle'
    end
  end
end