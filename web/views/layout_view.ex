defmodule PesquisaABMP.LayoutView do
  use PesquisaABMP.Web, :view

  def main_class(conn) do
    case Enum.join(conn.path_info, " ") |> String.strip()  do
      "" ->
        "home_container"
      classes ->
        classes
    end
  end
end
