# frozen_string_literal: true

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def size_range
    (10.kilobytes)..(50.megabytes)
  end

  version :thumb do
    process resize_to_fit: [100, 200]
  end

  version :medium do
    process resize_to_fit: [300, 400]
  end

  def extension_allowlist
    %w[jpg jpeg gif png]
  end
end
