defmodule HelloVersion.Repo do
  use Ecto.Repo,
    otp_app: :hello_version,
    adapter: Ecto.Adapters.Postgres
end
