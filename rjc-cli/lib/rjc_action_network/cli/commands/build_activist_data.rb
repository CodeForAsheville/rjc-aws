class RjcActionNetwork::Cli::Commands::BuildActivistData < RjcActionNetwork::Cli::Commands::Base
  desc 'Print version'

  def perform(*)
    RjcActionNetwork::ActivistCollectionBuilder.new.perform
  end
end
