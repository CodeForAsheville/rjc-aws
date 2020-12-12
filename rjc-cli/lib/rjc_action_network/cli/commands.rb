module RjcActionNetwork::Cli::Commands
  extend Hanami::CLI::Registry

  register 'version', RjcActionNetwork::Cli::Commands::Version, aliases: ['-v', '--version']
  register 'build', RjcActionNetwork::Cli::Commands::BuildActivistData
end
