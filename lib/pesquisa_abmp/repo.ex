defmodule PesquisaABMP.Repo do
  use Ecto.Repo, otp_app: :pesquisa_abmp
  use Scrivener, page_size: 20
end
