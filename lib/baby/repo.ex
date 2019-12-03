defmodule Baby.Repo do
  use Ecto.Repo,
    otp_app: :baby,
    adapter: Ecto.Adapters.Postgres
end
