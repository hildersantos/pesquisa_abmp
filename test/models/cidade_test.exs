defmodule PesquisaABMP.CidadeTest do
  use PesquisaABMP.ModelCase

  alias PesquisaABMP.Cidade

  @valid_attrs %{nome: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Cidade.changeset(%Cidade{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Cidade.changeset(%Cidade{}, @invalid_attrs)
    refute changeset.valid?
  end
end
