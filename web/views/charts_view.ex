defmodule Charts.ChartsView do
  use Charts.View

  defp show_path(conn, id) do
    charts_path(conn, :show, current_user(conn).id, id)
  end

  defp update_path(conn, id) do
    charts_path(conn, :update, current_user(conn).id, id)
  end

  defp create_path(conn) do
    charts_path(conn, :create, current_user(conn).id)
  end

  defp new_path(conn) do
    charts_path(conn, :new, current_user(conn).id)
  end

  defp edit_path(conn, id) do
    charts_path(conn, :edit, current_user(conn).id, id)
  end

  defp delete_path(conn, id) do
    charts_path(conn, :delete, current_user(conn).id, id)
  end

  defp persist?(changeset) do
    if changeset.model.id, do: true, else: false
  end

  defp button_text(changeset) do
    if persist?(changeset), do: "Update", else: "Create"
  end


end
