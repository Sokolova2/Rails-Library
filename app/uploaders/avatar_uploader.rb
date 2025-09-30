# frozen_string_literal: true

class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def size_range
    (10.kilobytes)..(50.megabytes)
  end

  def extension_allowlist
    %w[jpg jpeg png]
  end
end
