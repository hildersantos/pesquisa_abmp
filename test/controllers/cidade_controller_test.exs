defmodule PesquisaABMP.CidadeControllerTest do
  use PesquisaABMP.ConnCase

  alias PesquisaABMP.Cidade
  @valid_attrs %{nome: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, cidade_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing cidades"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, cidade_path(conn, :new)
    assert html_response(conn, 200) =~ "New cidade"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, cidade_path(conn, :create), cidade: @valid_attrs
    assert redirected_to(conn) == cidade_path(conn, :index)
    assert Repo.get_by(Cidade, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, cidade_path(conn, :create), cidade: @invalid_attrs
    assert html_response(conn, 200) =~ "New cidade"
  end

  test "shows chosen resource", %{conn: conn} do
    cidade = Repo.insert! %Cidade{}
    conn = get conn, cidade_path(conn, :show, cidade)
    assert html_response(conn, 200) =~ "Show cidade"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, cidade_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    cidade = Repo.insert! %Cidade{}
    conn = get conn, cidade_path(conn, :edit, cidade)
    assert html_response(conn, 200) =~ "Edit cidade"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    cidade = Repo.insert! %Cidade{}
    conn = put conn, cidade_path(conn, :update, cidade), cidade: @valid_attrs
    assert redirected_to(conn) == cidade_path(conn, :show, cidade)
    assert Repo.get_by(Cidade, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    cidade = Repo.insert! %Cidade{}
    conn = put conn, cidade_path(conn, :update, cidade), cidade: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit cidade"
  end

  test "deletes chosen resource", %{conn: conn} do
    cidade = Repo.insert! %Cidade{}
    conn = delete conn, cidade_path(conn, :delete, cidade)
    assert redirected_to(conn) == cidade_path(conn, :index)
    refute Repo.get(Cidade, cidade.id)
  end
end
