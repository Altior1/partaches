defmodule Partaches.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PartachesWeb.Telemetry,
      Partaches.Repo,
      {DNSCluster, query: Application.get_env(:partaches, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Partaches.PubSub},
      # Start a worker by calling: Partaches.Worker.start_link(arg)
      # {Partaches.Worker, arg},
      # Start to serve requests, typically the last entry
      PartachesWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Partaches.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PartachesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
