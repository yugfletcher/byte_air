defmodule ByteAir.SensorBoundaryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ByteAir.SensorBoundary` context.
  """

  @doc """
  Generate a bme688_reading.
  """
  def bme688_reading_fixture(attrs \\ %{}) do
    {:ok, bme688_reading} =
      attrs
      |> Enum.into(%{
        gas: 120.5,
        humidity: 120.5,
        name: "some name",
        pressure: 120.5,
        temperature: 120.5
      })
      |> ByteAir.SensorBoundary.create_bme688_reading()

    bme688_reading
  end

  @doc """
  Generate a pms5003_reading.
  """
  def pms5003_reading_fixture(attrs \\ %{}) do
    {:ok, pms5003_reading} =
      attrs
      |> Enum.into(%{
        name: "some name",
        pm10: 42,
        pm1_0: 42,
        pm2_5: 42
      })
      |> ByteAir.SensorBoundary.create_pms5003_reading()

    pms5003_reading
  end
end
