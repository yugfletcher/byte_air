defmodule ByteAirWeb.DashboardLive do
  use ByteAirWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="bg-middle-blue-green flex flex-col min-h-screen">
      <h1 class="text-center italic font-bold text-white text-4xl p-8 ">
        Byte Air !
      </h1>
      <div class="gap-4 md:flex flex-col lg:grid grid-cols-3 grid-rows-2 px-4">
        <%= make_line_chart() %>
        <%= make_line_chart() %>
        <%= make_line_chart() %>
        <%= make_line_chart() %>
      </div>
    </div>
    <div>
      <div>
        <%= make_line_chart() %>
      </div>
    </div>
    """
  end

  def make_line_chart() do
    data = [{1, 34, 70}, {2, 5, 70}, {3, 60, 90}, {4, 46, 93}]

    # more_data = [{1, 40}, {2, 9}, {3, 70}, {4, 56}]

    # big_data = [data, more_data]

    omega_data = [[1, 2, 3, 4, 5], [6, 7, 8, 9, 10]]

    plot_options = %{
      top_margin: 5,
      right_margin: 5,
      bottom_margin: 5,
      left_margin: 5,
      show_x_axis: true,
      show_y_axis: true
    }

    output =
      data
      |> Contex.Dataset.new(["Timey", "Temp?", "E-Level?"])
      |> Contex.Plot.new(Contex.LinePlot, 800, 400,
        y_label: "champ",
        title: "poggers",
        x_label: "Timey",
        mapping: %{x_col: "Timey", y_cols: ["Temp?", "E-Level?"]},
        legend_setting: :legend_right
      )
      |> Contex.Plot.to_svg()

    output
  end
end
