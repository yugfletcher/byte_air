defmodule ByteAirWeb.DashboardLive do
  alias Phoenix.PubSub
  alias ByteAir.SensorBoundary
  use ByteAirWeb, :live_view

  def mount(_params, _session, socket) do
    if connected?(socket) do
      PubSub.subscribe(ByteAir.PubSub, "bme688_topic")
      PubSub.subscribe(ByteAir.PubSub, "pms5003_topic")
    end

    {:ok,
     assign(socket,
       bme688readings: SensorBoundary.list_bme688readings(),
       pms5003readings: SensorBoundary.list_pms5003readings()
     )}
  end

  def render(assigns) do
    ~H"""
    <div class="bg-middle-blue-green flex flex-col min-h-screen">
      <h1 class="text-center italic font-bold text-white text-4xl p-8 ">
        Byte Air !
      </h1>
      <div class="gap-4 md:flex flex-col lg:grid grid-cols-2 grid-rows-2 px-4">
        <%= bme688_temp_humidity(@bme688readings) %>
        <%= bme688_pressure(@bme688readings) %>
        <div>
          <%= bme688_gas(@bme688readings) %>
          <h1>
            The stat above is a measurement for everything tiny in the air, from unhealthy volitile organic compounds (VOCs) to innocuous carbon monoxide & hydrogen in parts per billion.
          </h1>
        </div>
        <%= make_pms5003_line_chart(@pms5003readings) %>
      </div>
    </div>
    <div class="bg-opal flex flex-col">
      <div class="gap-4 md:flex flex-col lg:grid grid-cols-2 grid-rows-1 px-4">
        <.table id="bme688_table" rows={@bme688readings}>
          <:col :let={bme688_elem} label="name"><%= bme688_elem.name %></:col>
          <:col :let={bme688_elem} label="temperature"><%= bme688_elem.temperature %></:col>
          <:col :let={bme688_elem} label="pressure"><%= bme688_elem.pressure %></:col>
          <:col :let={bme688_elem} label="humidity"><%= bme688_elem.humidity %></:col>
          <:col :let={bme688_elem} label="gas"><%= bme688_elem.gas %></:col>
        </.table>
        <.table id="pms5003_table" rows={@pms5003readings}>
          <:col :let={pms5003_elem} label="name"><%= pms5003_elem.name %></:col>
          <:col :let={pms5003_elem} label="pm1_0"><%= pms5003_elem.pm1_0 %></:col>
          <:col :let={pms5003_elem} label="pm2_5"><%= pms5003_elem.pm2_5 %></:col>
          <:col :let={pms5003_elem} label="pm10"><%= pms5003_elem.pm10 %></:col>
        </.table>
      </div>
    </div>
    """
  end

  def handle_info({:update_bme688, _bme688_reading}, socket) do
    {:noreply, assign(socket, bme688readings: SensorBoundary.list_bme688readings())}
  end

  def handle_info({:update_pms5003, _pms5003_reading}, socket) do
    {:noreply, assign(socket, pms5003readings: SensorBoundary.list_pms5003readings())}
  end

  def make_line_chart() do
    data = [{1, 34, 70}, {2, 5, 70}, {3, 60, 90}, {4, 46, 93}]

    # more_data = [{1, 40}, {2, 9}, {3, 70}, {4, 56}]

    # big_data = [data, more_data]

    _omega_data = [[1, 2, 3, 4, 5], [6, 7, 8, 9, 10]]

    _plot_options = %{
      top_margin: 5,
      right_margin: 5,
      bottom_margin: 5,
      left_margin: 5,
      show_x_axis: true,
      show_y_axis: true
    }

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
  end

  def make_bme688_line_chart(bme688_readings) do
    bme688_readings
    |> Enum.map(fn %{
                     inserted_at: timestamp,
                     temperature: temperature,
                     pressure: pressure,
                     humidity: humidity,
                     gas: gas
                   } ->
      [timestamp, temperature, pressure, humidity, gas]
    end)
    |> Contex.Dataset.new(["Time", "Temp", "Pressure", "Humidity", "Gas"])
    |> Contex.Plot.new(
      Contex.LinePlot,
      800,
      400,
      mapping: %{x_col: "Time", y_cols: ["Temp", "Pressure", "Humidity", "Gas"]},
      title: "BME688 Readings",
      x_label: "Time",
      legend_setting: :legend_right
    )
    |> Contex.Plot.to_svg()
  end

  def bme688_temp_humidity(bme688_readings) do
    bme688_readings
    |> Enum.map(fn %{
                     inserted_at: timestamp,
                     temperature: temperature,
                     humidity: humidity
                   } ->
      [timestamp, temperature, humidity]
    end)
    |> Contex.Dataset.new(["Time", "Temp", "Humidity"])
    |> Contex.Plot.new(
      Contex.LinePlot,
      800,
      400,
      mapping: %{x_col: "Time", y_cols: ["Temp", "Humidity"]},
      title: "BME688 Temperature & Humidity Readings",
      x_label: "Time",
      legend_setting: :legend_right
    )
    |> Contex.Plot.to_svg()
  end

  def bme688_pressure(bme688_readings) do
    bme688_readings
    |> Enum.map(fn %{
                     inserted_at: timestamp,
                     pressure: pressure
                   } ->
      [timestamp, pressure]
    end)
    |> Contex.Dataset.new(["Time", "Pressure"])
    |> Contex.Plot.new(
      Contex.LinePlot,
      800,
      400,
      mapping: %{x_col: "Time", y_cols: ["Pressure"]},
      title: "BME688 Pressure Readings",
      x_label: "Time",
      legend_setting: :legend_right
    )
    |> Contex.Plot.to_svg()
  end

  def bme688_gas(bme688_readings) do
    bme688_readings
    |> Enum.map(fn %{
                     inserted_at: timestamp,
                     gas: gas
                   } ->
      [timestamp, gas]
    end)
    |> Contex.Dataset.new(["Time", "Gas"])
    |> Contex.Plot.new(
      Contex.LinePlot,
      800,
      400,
      mapping: %{x_col: "Time", y_cols: ["Gas"]},
      title: "BME688 Gas Readings",
      x_label: "Time",
      legend_setting: :legend_right
    )
    |> Contex.Plot.to_svg()
  end

  def make_pms5003_line_chart(pms5003_readings) do
    pms5003_readings
    |> Enum.map(fn %{
                     inserted_at: timestamp,
                     pm1_0: pm1_0,
                     pm2_5: pm2_5,
                     pm10: pm10
                   } ->
      [timestamp, pm1_0, pm2_5, pm10]
    end)
    |> Contex.Dataset.new(["Time", "PM1.0", "PM2.5", "PM10"])
    |> Contex.Plot.new(
      Contex.LinePlot,
      800,
      400,
      mapping: %{x_col: "Time", y_cols: ["PM1.0", "PM2.5", "PM10"]},
      title: "PMS5003 Particulate Matter Readings",
      x_label: "Time",
      legend_setting: :legend_right
    )
    |> Contex.Plot.to_svg()
  end
end
