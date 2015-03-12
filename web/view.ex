defmodule Charts.View do
  use Phoenix.View, root: "web/templates"

  # The quoted expression returned by this block is applied
  # to this module and all other views that use this module.
  using do
    quote do
      # Import common functionality
      import Charts.Router.Helpers
      require IEx
      # Use Phoenix.HTML to import all HTML functions (forms, tags, etc)
      use Phoenix.HTML
    end
  end

  # Functions defined here are available to all other views/templates
  def has_error?(changeset, key) do
    Keyword.has_key?(changeset.errors, key)
  end

  def current_user(conn) do
    Charts.UsersController.current_user(conn)
  end
end
