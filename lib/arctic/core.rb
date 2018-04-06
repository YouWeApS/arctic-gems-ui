require 'pathname'
$: << File.expand_path(Pathname.new('.').join('lib'))

ENV['RACK_ENV'] ||= 'development'

require 'active_support/all'

require 'arctic/core/version'
require 'arctic/core/configuration'
require 'arctic/core/api'

module Arctic
  module Core
  end
end
