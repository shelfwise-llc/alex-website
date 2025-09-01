defmodule AlexWebsite.Repo do
  use Ecto.Repo,
    otp_app: :alex_website,
    adapter: Ecto.Adapters.Postgres
end
