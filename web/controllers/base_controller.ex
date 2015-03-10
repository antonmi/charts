defmodule Charts.BaseController do

  defmacro __using__(_opts) do
    quote do
      use Phoenix.Controller
      import Charts.Router.Helpers

      require IEx


      defp current_user(conn) do
        user_id = get_session(conn, :user_id)
        user = user_id && PhoenixJobs.Repo.get(PhoenixJobs.User, user_id)
      end

      defp check_auth(conn, _params) do
        if current_user(conn) do
          conn
        else
          # redirect conn, to: pages_path(conn, :index)
          # halt conn
        end
      end

    end
  end

end
