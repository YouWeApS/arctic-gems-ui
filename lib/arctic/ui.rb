require 'pathname'
$: << File.expand_path(Pathname.new('.').join('lib'))

ENV['RACK_ENV'] ||= 'development'

require 'active_support/all'

require 'arctic/ui/version'
require 'arctic/ui/configuration'
require 'arctic/ui/api'

module Arctic
  module UI
  end
end
