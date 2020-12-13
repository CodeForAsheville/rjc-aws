require 'hanami/cli'

class RjcActionNetwork::Cli::Commands::Base < Hanami::CLI::Command
  def call(*args)
    perform(*args)
  end

  def perform
    raise NotImplementedError
  end

  def stderr(message)
    STDERR.puts message
  end

  def stdout(message)
    STDOUT.puts message
  end
end
