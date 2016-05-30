defmodule PesquisaABMP.EmpresaTest do
  use PesquisaABMP.ModelCase

  alias PesquisaABMP.Empresa

  @valid_attrs %{cep: "some content", diretor1: "some content", diretor2: "some content", email1: "some content", email2: "some content", endereco: "some content", site: "some content", telefone: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Empresa.changeset(%Empresa{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Empresa.changeset(%Empresa{}, @invalid_attrs)
    refute changeset.valid?
  end
end
