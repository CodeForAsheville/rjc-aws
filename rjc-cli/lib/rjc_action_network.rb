require 'yaml'
require 'pathname'

begin
  require 'dotenv'
  Dotenv.load '.env.local', '.env'
rescue LoadError # rubocop:disable Lint/HandleExceptions
end

require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.setup

module RjcActionNetwork
  class Error < StandardError; end

  def self.root
    Pathname.new File.dirname __dir__
  end

  def self.data_dir
    root.join 'data'
  end
end
