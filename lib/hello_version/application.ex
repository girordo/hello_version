defmodule HelloVersion.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      HelloVersionWeb.Telemetry,
      # Start the Ecto repository
      HelloVersion.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: HelloVersion.PubSub},
      # Start Finch
      {Finch, name: HelloVersion.Finch},
      # Start the Endpoint (http/https)
      HelloVersionWeb.Endpoint
      # Start a worker by calling: HelloVersion.Worker.start_link(arg)
      # {HelloVersion.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HelloVersion.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HelloVersionWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
