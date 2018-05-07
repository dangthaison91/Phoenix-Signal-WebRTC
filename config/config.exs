# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :signal_webrtc2,
  ecto_repos: [SignalWebrtc2.Repo]

# Configures the endpoint
config :signal_webrtc2, SignalWebrtc2Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/NWH+3AN6IEOnYI9sq+9+ZVFzGCjdns+PDKOvNrKJaDpMiiyXjBS0YDU15CebYBd",
  render_errors: [view: SignalWebrtc2Web.ErrorView, accepts: ~w(json)],
  pubsub: [name: SignalWebrtc2.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
