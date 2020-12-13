require 'hanami/cli'

module RjcActionNetwork::Cli
  require 'rjc_action_network/cli/commands'

  class App
    def call(*args)
      Hanami::CLI.new(RjcActionNetwork::Cli::Commands).call(*args)
    end
  end
end
