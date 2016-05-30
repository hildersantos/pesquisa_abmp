defmodule PesquisaABMP.SegmentoControllerTest do
  use PesquisaABMP.ConnCase

  alias PesquisaABMP.Segmento
  @valid_attrs %{nome: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, segmento_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing segmentos"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, segmento_path(conn, :new)
    assert html_response(conn, 200) =~ "New segmento"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, segmento_path(conn, :create), segmento: @valid_attrs
    assert redirected_to(conn) == segmento_path(conn, :index)
    assert Repo.get_by(Segmento, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, segmento_path(conn, :create), segmento: @invalid_attrs
    assert html_response(conn, 200) =~ "New segmento"
  end

  test "shows chosen resource", %{conn: conn} do
    segmento = Repo.insert! %Segmento{}
    conn = get conn, segmento_path(conn, :show, segmento)
    assert html_response(conn, 200) =~ "Show segmento"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, segmento_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    segmento = Repo.insert! %Segmento{}
    conn = get conn, segmento_path(conn, :edit, segmento)
    assert html_response(conn, 200) =~ "Edit segmento"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    segmento = Repo.insert! %Segmento{}
    conn = put conn, segmento_path(conn, :update, segmento), segmento: @valid_attrs
    assert redirected_to(conn) == segmento_path(conn, :show, segmento)
    assert Repo.get_by(Segmento, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    segmento = Repo.insert! %Segmento{}
    conn = put conn, segmento_path(conn, :update, segmento), segmento: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit segmento"
  end

  test "deletes chosen resource", %{conn: conn} do
    segmento = Repo.insert! %Segmento{}
    conn = delete conn, segmento_path(conn, :delete, segmento)
    assert redirected_to(conn) == segmento_path(conn, :index)
    refute Repo.get(Segmento, segmento.id)
  end
end
