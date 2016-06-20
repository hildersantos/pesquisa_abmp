# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PesquisaABMP.Repo.insert!(%PesquisaABMP.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias PesquisaABMP.Repo
alias PesquisaABMP.TipoEmpresa

for tipo_empresa <- ~w(ME Ltda. S.A. Outro) do
    Repo.insert!(%TipoEmpresa{nome: tipo_empresa})
end
