defmodule AlexWebsite.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AlexWebsiteWeb.Telemetry,
      AlexWebsite.Repo,
      {Phoenix.PubSub, name: AlexWebsite.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: AlexWebsite.Finch},
      # Start a worker by calling: AlexWebsite.Worker.start_link(arg)
      # {AlexWebsite.Worker, arg},
      # Start to serve requests, typically the last entry
      AlexWebsiteWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AlexWebsite.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AlexWebsiteWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
