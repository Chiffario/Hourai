defmodule Hourai.Repo do
  use Ecto.Repo,
    otp_app: :hourai,
    adapter: Ecto.Adapters.Postgres
end
