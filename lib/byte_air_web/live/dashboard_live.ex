defmodule ByteAirWeb.DashboardLive do
  use ByteAirWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>hello</h1>
    """
  end
end
