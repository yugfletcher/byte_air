defmodule ByteAir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    # ByteAir.Release.migrate()

    children = [
      # Start the Telemetry supervisor
      ByteAirWeb.Telemetry,
      # Start the Ecto repository
      ByteAir.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: ByteAir.PubSub},
      # Start Finch
      {Finch, name: ByteAir.Finch},
      # Start the Endpoint (http/https)
      ByteAirWeb.Endpoint
      # Start a worker by calling: ByteAir.Worker.start_link(arg)
      # {ByteAir.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ByteAir.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ByteAirWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
