defmodule Charts.UsersController do
  use Charts.BaseController

  plug :action

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, params) do
    if Charts.UserRepo.create(params["username"], params["password"]) do
      redirect conn, to: page_path(conn, :index)
    else
      #TODO
    end
  end

  def login(conn, _params) do
    render conn, "login.html"
  end

  def process_login(conn, params) do
    user = Charts.UserRepo.find_by_username(params["name"])
    if user && user.passhash == Crypto.md5(params["password"]) do
      conn |> put_session(:user_id, user.id)
      |> put_flash(:notice, "Successfully logged in!")
      |> redirect to: page_path(conn, :index)
    else
      conn |> put_flash(:notice, "Wrong name or password")
      |> redirect to: users_path(conn, :login)
    end
  end

  def logout(conn, params) do
    user = Charts.UserRepo.get(Chrats.User, params["id"])
    conn |> put_session( :user_id, nil)
    |> put_flash(:notice, "Successfully logged out!")
    |> redirect to: page_path(conn, :index)
  end
end
