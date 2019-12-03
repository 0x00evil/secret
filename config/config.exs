# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :baby,
  ecto_repos: [Baby.Repo]

# Configures the endpoint
config :baby, BabyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ipRayAwtXOYKZ+az+50d9kNxadBMq4a+z4wWFkxyNHwfd0963yiRochqm96Ra3DQ",
  render_errors: [view: BabyWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Baby.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
