defmodule ByteAirWeb.PMS5003ReadingJSON do
  alias ByteAir.SensorBoundary.PMS5003Reading

  @doc """
  Renders a list of pms5003readings.
  """
  def index(%{pms5003readings: pms5003readings}) do
    %{data: for(pms5003_reading <- pms5003readings, do: data(pms5003_reading))}
  end

  @doc """
  Renders a single pms5003_reading.
  """
  def show(%{pms5003_reading: pms5003_reading}) do
    %{data: data(pms5003_reading)}
  end

  defp data(%PMS5003Reading{} = pms5003_reading) do
    %{
      id: pms5003_reading.id,
      name: pms5003_reading.name,
      pm1_0: pms5003_reading.pm1_0,
      pm2_5: pms5003_reading.pm2_5,
      pm10: pms5003_reading.pm10
    }
  end
end
