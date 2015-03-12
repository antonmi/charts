defmodule Charts.UsersController do
  use Charts.BaseController

  plug :auth when action in [:dashboard]
  plug :action

  def dashboard(conn, _params) do
    render conn, "dashboard.html"
  end

  def new(conn, _params) do
    render conn, "new.html", changeset: %Ecto.Changeset{}
  end

  def create(conn, params) do
    changeset  = Charts.User.changeset(%Charts.User{}, params)
    if changeset.valid? do
      user = Charts.UserRepo.create(params["username"], params["password"])
      conn |> put_session(:user_id, user.id)
      |> redirect to: users_path(conn, :dashboard, user.id)
    else
      conn |> put_flash(:error, Charts.User.full_error_message(changeset))
      |> render "new.html", changeset: changeset
    end
  end

  def login(conn, _params) do
    render conn, "login.html", changeset: %Ecto.Changeset{}
  end

  def process_login(conn, params) do
    user = Charts.UserRepo.find_by_username(params["username"])
    if user && user.passhash == Charts.Crypto.md5(params["password"]) do
      conn |> put_session(:user_id, user.id)
      |> put_flash(:notice, "Successfully logged in!")
      |> redirect to: users_path(conn, :dashboard, user.id)
    else
      conn |> put_flash(:error, "Wrong login or password")
      |> redirect to: users_path(conn, :login)
    end
  end

  def logout(conn, _params) do
    user = current_user(conn)
    conn |> put_session(:user_id, nil)
    |> put_flash(:notice, "Successfully logged out!")
    |> redirect to: page_path(conn, :index)
  end
end
