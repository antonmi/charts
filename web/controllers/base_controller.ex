defmodule Charts.BaseController do

  defmacro __using__(_opts) do
    quote do
      use Phoenix.Controller
      import Charts.Router.Helpers
      require IEx

      plug :set_current_user

      def current_user(conn) do
        conn.assigns[:current_user]
      end

      defp set_current_user(conn, _params) do
        user_id = get_session(conn, :user_id)
        user = user_id && Charts.Repo.get(Charts.User, user_id)
        if user, do: assign(conn, :current_user, user), else: conn
      end

      defp auth(conn, params) do
        user_id = if conn.params["user_id"], do: String.to_integer(conn.params["user_id"]), else: nil
        current_user = current_user(conn)
        if current_user && current_user.id == user_id do
          conn
        else
          conn |> put_flash(:error, "Please, log in!")
          |> redirect to: users_path(conn, :login)
          conn
        end
      end

    end
  end

end
