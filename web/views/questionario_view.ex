defmodule PesquisaABMP.QuestionarioView do
  use PesquisaABMP.Web, :view

  def render("index.json", %{questionarios: questionarios}) do
    %{data: render_many(questionarios, PesquisaABMP.QuestionarioView, "questionario.json")}
  end

  def render("show.json", %{questionario: questionario}) do
    %{data: render_one(questionario, PesquisaABMP.QuestionarioView, "questionario.json")}
  end

  def render("questionario.json", %{questionario: questionario}) do
    %{
      id: questionario.id,
      nome: questionario.nome,
      perguntas: render_many(questionario.perguntas, __MODULE__, "pergunta.json", as: :pergunta)
    }
  end

  def render("pergunta.json", %{pergunta: pergunta}) do
    %{
      id: pergunta.id,
      tipo: pergunta.tipo,
      pergunta: pergunta.pergunta,
      observacao: pergunta.observacao,
      respostas: render_many(pergunta.respostas, __MODULE__, "resposta.json", as: :resposta)
    }
  end

  def render("resposta.json", %{resposta: resposta}) do
    %{
      id: resposta.id,
      resposta: resposta.resposta
    }
  end
end
