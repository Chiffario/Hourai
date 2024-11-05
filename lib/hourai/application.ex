defmodule Hourai.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HouraiWeb.Telemetry,
      Hourai.Repo,
      {DNSCluster, query: Application.get_env(:hourai, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Hourai.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Hourai.Finch},
      # Start a worker by calling: Hourai.Worker.start_link(arg)
      # {Hourai.Worker, arg},
      # Start to serve requests, typically the last entry
      HouraiWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Hourai.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HouraiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
