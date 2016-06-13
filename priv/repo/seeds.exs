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

PesquisaABMP.Repo.transaction fn ->

  questionario = PesquisaABMP.Repo.insert!(%PesquisaABMP.Questionario{nome: "Questionário Padrão"})

  pergunta = Ecto.build_assoc(questionario, :perguntas, tipo: "radio", pergunta: "Esse é um teste de pergunta?" ) |> PesquisaABMP.Repo.insert!()

  resposta = Ecto.build_assoc(pergunta, :respostas, resposta: "Sim, esta é uma pergunta") |> PesquisaABMP.Repo.insert!()
end
