# frozen_string_literal: true

require 'spec_helper'
require 'dotenv/load'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

RSpec.configure do |config|
  config.before(:suite) do
    Mongoid.purge!
  end

  config.use_active_record = false

  config.filter_rails_from_backtrace!
  config.include Mongoid::Matchers, type: :model
  config.include FactoryBot::Syntax::Methods
  Mongoid.load!(Rails.root.join('config/mongoid.yml'), :test)
end
