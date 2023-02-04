defmodule ByteAirWeb.PMS5003ReadingController do
  use ByteAirWeb, :controller

  alias ByteAir.SensorBoundary
  alias ByteAir.SensorBoundary.PMS5003Reading

  action_fallback ByteAirWeb.FallbackController

  def index(conn, _params) do
    pms5003readings = SensorBoundary.list_pms5003readings()
    render(conn, :index, pms5003readings: pms5003readings)
  end

  def create(conn, %{"pms5003_reading" => pms5003_reading_params}) do
    with {:ok, %PMS5003Reading{} = pms5003_reading} <- SensorBoundary.create_pms5003_reading(pms5003_reading_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/pms5003readings/#{pms5003_reading}")
      |> render(:show, pms5003_reading: pms5003_reading)
    end
  end

  def show(conn, %{"id" => id}) do
    pms5003_reading = SensorBoundary.get_pms5003_reading!(id)
    render(conn, :show, pms5003_reading: pms5003_reading)
  end

  def update(conn, %{"id" => id, "pms5003_reading" => pms5003_reading_params}) do
    pms5003_reading = SensorBoundary.get_pms5003_reading!(id)

    with {:ok, %PMS5003Reading{} = pms5003_reading} <- SensorBoundary.update_pms5003_reading(pms5003_reading, pms5003_reading_params) do
      render(conn, :show, pms5003_reading: pms5003_reading)
    end
  end

  def delete(conn, %{"id" => id}) do
    pms5003_reading = SensorBoundary.get_pms5003_reading!(id)

    with {:ok, %PMS5003Reading{}} <- SensorBoundary.delete_pms5003_reading(pms5003_reading) do
      send_resp(conn, :no_content, "")
    end
  end
end
