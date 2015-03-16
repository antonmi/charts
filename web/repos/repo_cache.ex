defmodule Charts.RepoCache do

  use GenServer

  @init_state HashDict.new

  def start_link() do
    {ok, pid} = GenServer.start_link(Charts.RepoCache, [])
    Process.register(pid, __MODULE__)
    {ok, pid}
  end

  def set(repo, key, value) do
    GenServer.call(__MODULE__, {:set, repo, key, value})
  end

  def get(repo, key) do
    GenServer.call(__MODULE__, {:get, repo, key})
  end

  def del(repo, key) do
    GenServer.call(__MODULE__, {:del, repo, key})
  end

  def clear do
    GenServer.call(__MODULE__, :clear)
  end

  def state do
    GenServer.call(__MODULE__, :state)
  end

  def init(_state) do
    {:ok, @init_state}
  end

  def handle_call({:set, repo, key, value},_from, state) do
    state = Dict.put(state, dkey(repo, key), value)
     {:reply, {key, value}, state}
  end

  def handle_call({:get, repo, key},_from, state) do
    value = Dict.get(state, dkey(repo, key))
     {:reply, value, state}
  end

  def handle_call({:del, repo, key},_from, state) do
    value = Dict.delete(state, dkey(repo, key))
     {:reply, value, state}
  end

  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end

  def handle_call(:clear, _from, _state) do
    {:reply, :ok, @init_state}
  end

  defp dkey(repo, key), do: Atom.to_string(repo) <> "_#{key}"

end
