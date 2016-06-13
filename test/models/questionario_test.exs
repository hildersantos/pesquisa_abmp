defmodule PesquisaABMP.QuestionarioTest do
  use PesquisaABMP.ModelCase

  alias PesquisaABMP.Questionario

  @valid_attrs %{nome: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Questionario.changeset(%Questionario{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Questionario.changeset(%Questionario{}, @invalid_attrs)
    refute changeset.valid?
  end
end
