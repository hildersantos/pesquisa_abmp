defmodule PesquisaABMP.TipoEmpresaTest do
  use PesquisaABMP.ModelCase

  alias PesquisaABMP.TipoEmpresa

  @valid_attrs %{nome: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = TipoEmpresa.changeset(%TipoEmpresa{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = TipoEmpresa.changeset(%TipoEmpresa{}, @invalid_attrs)
    refute changeset.valid?
  end
end
