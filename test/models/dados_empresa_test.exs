defmodule PesquisaABMP.DadosEmpresaTest do
  use PesquisaABMP.ModelCase

  alias PesquisaABMP.DadosEmpresa

  @valid_attrs %{endereco: "some content", facebook: "some content", filial: "some content", instagram: "some content", nome: "some content", num_func_homens: 42, num_func_mulheres: 42, num_funcionarios: 42, num_socios: 42, site: "some content", telefone: "some content", tempo_atividade: 42, twitter: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = DadosEmpresa.changeset(%DadosEmpresa{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = DadosEmpresa.changeset(%DadosEmpresa{}, @invalid_attrs)
    refute changeset.valid?
  end
end
