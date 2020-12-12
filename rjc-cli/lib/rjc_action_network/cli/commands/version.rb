class RjcActionNetwork::Cli::Commands::Version < RjcActionNetwork::Cli::Commands::Base
  desc 'Print version'

  def perform(*)
    stdout ::RjcActionNetwork::VERSION
  end
end
