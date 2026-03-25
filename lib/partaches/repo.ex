defmodule Partaches.Repo do
  use Ecto.Repo,
    otp_app: :partaches,
    adapter: Ecto.Adapters.Postgres
end
