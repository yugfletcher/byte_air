defmodule ByteAirWeb.BME688ReadingController do
  use ByteAirWeb, :controller

  alias ByteAir.SensorBoundary
  alias ByteAir.SensorBoundary.BME688Reading

  action_fallback ByteAirWeb.FallbackController

  def index(conn, _params) do
    bme688readings = SensorBoundary.list_bme688readings()
    render(conn, :index, bme688readings: bme688readings)
  end

  def create(conn, %{"bme688_reading" => bme688_reading_params}) do
    with {:ok, %BME688Reading{} = bme688_reading} <- SensorBoundary.create_bme688_reading(bme688_reading_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/bme688readings/#{bme688_reading}")
      |> render(:show, bme688_reading: bme688_reading)
    end
  end

  def show(conn, %{"id" => id}) do
    bme688_reading = SensorBoundary.get_bme688_reading!(id)
    render(conn, :show, bme688_reading: bme688_reading)
  end

  def update(conn, %{"id" => id, "bme688_reading" => bme688_reading_params}) do
    bme688_reading = SensorBoundary.get_bme688_reading!(id)

    with {:ok, %BME688Reading{} = bme688_reading} <- SensorBoundary.update_bme688_reading(bme688_reading, bme688_reading_params) do
      render(conn, :show, bme688_reading: bme688_reading)
    end
  end

  def delete(conn, %{"id" => id}) do
    bme688_reading = SensorBoundary.get_bme688_reading!(id)

    with {:ok, %BME688Reading{}} <- SensorBoundary.delete_bme688_reading(bme688_reading) do
      send_resp(conn, :no_content, "")
    end
  end
end
