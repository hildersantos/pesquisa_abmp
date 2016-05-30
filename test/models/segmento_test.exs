defmodule PesquisaABMP.SegmentoTest do
  use PesquisaABMP.ModelCase

  alias PesquisaABMP.Segmento

  @valid_attrs %{nome: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Segmento.changeset(%Segmento{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Segmento.changeset(%Segmento{}, @invalid_attrs)
    refute changeset.valid?
  end
end
