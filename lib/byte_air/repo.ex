defmodule ByteAir.Repo do
  use Ecto.Repo,
    otp_app: :byte_air,
    adapter: Ecto.Adapters.SQLite3
end
