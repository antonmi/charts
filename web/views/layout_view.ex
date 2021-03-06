defmodule Charts.LayoutView do
  use Charts.View

  def menu_item([_user_id, "charts"]), do: :charts
  def menu_item([_user_id, "charts", _id]), do: :charts
  def menu_item([_user_id, "charts", _id, _action]), do: :charts
  def menu_item([_user_id, "dashboard"]), do: :dashboard
  def menu_item([_user_id, "settings"]), do: :settings
  def menu_item(["users", "new"]), do: :sign_up
  def menu_item(["users", "login"]), do: :log_in
  def menu_item(_), do: :something


end
