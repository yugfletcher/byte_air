defmodule ByteAirWeb.BME688ReadingJSON do
  alias ByteAir.SensorBoundary.BME688Reading

  @doc """
  Renders a list of bme688readings.
  """
  def index(%{bme688readings: bme688readings}) do
    %{data: for(bme688_reading <- bme688readings, do: data(bme688_reading))}
  end

  @doc """
  Renders a single bme688_reading.
  """
  def show(%{bme688_reading: bme688_reading}) do
    %{data: data(bme688_reading)}
  end

  defp data(%BME688Reading{} = bme688_reading) do
    %{
      id: bme688_reading.id,
      name: bme688_reading.name,
      temperature: bme688_reading.temperature,
      pressure: bme688_reading.pressure,
      humidity: bme688_reading.humidity,
      gas: bme688_reading.gas
    }
  end
end
