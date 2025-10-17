# frozen_string_literal: true

class SetRandomAvatarService
  def initialize(user)
    @user = user
  end

  def set_random_avatar
    return if @user.avatar.present?

    if @user.gender.nil? || @user.gender == 'gender'
      set_avatar_without_gender
    else
      set_avatar_with_gender
    end
  end

  def set_avatar_without_gender
    avatar = Rails.root.glob('app/assets/images/animal/*.png')
    random_avatar = avatar.sample

    @user.avatar = File.open(random_avatar)
    @user.avatar_filename = File.basename(random_avatar)
  end

  def set_avatar_with_gender
    gender = @user.gender == 'female' ? 'female' : 'male'
    avatar = Rails.root.glob("app/assets/images/#{gender}/*.png")
    random_avatar = avatar.sample

    @user.avatar = File.open(random_avatar)
    @user.avatar_filename = File.basename(random_avatar)
  end
end
