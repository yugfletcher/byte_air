defmodule ByteAir.SensorBoundary do
  @moduledoc """
  The SensorBoundary context.
  """

  import Ecto.Query, warn: false
  alias ByteAir.Repo

  alias ByteAir.SensorBoundary.BME688Reading

  @doc """
  Returns the list of bme688readings.

  ## Examples

      iex> list_bme688readings()
      [%BME688Reading{}, ...]

  """
  def list_bme688readings do
    Repo.all(BME688Reading)
  end

  @doc """
  Gets a single bme688_reading.

  Raises `Ecto.NoResultsError` if the Bme688 reading does not exist.

  ## Examples

      iex> get_bme688_reading!(123)
      %BME688Reading{}

      iex> get_bme688_reading!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bme688_reading!(id), do: Repo.get!(BME688Reading, id)

  @doc """
  Creates a bme688_reading.

  ## Examples

      iex> create_bme688_reading(%{field: value})
      {:ok, %BME688Reading{}}

      iex> create_bme688_reading(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bme688_reading(attrs \\ %{}) do
    %BME688Reading{}
    |> BME688Reading.changeset(attrs)
    |> Repo.insert()
    |> broadcast(:update_bme688)
  end

  @doc """
  Updates a bme688_reading.

  ## Examples

      iex> update_bme688_reading(bme688_reading, %{field: new_value})
      {:ok, %BME688Reading{}}

      iex> update_bme688_reading(bme688_reading, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bme688_reading(%BME688Reading{} = bme688_reading, attrs) do
    bme688_reading
    |> BME688Reading.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bme688_reading.

  ## Examples

      iex> delete_bme688_reading(bme688_reading)
      {:ok, %BME688Reading{}}

      iex> delete_bme688_reading(bme688_reading)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bme688_reading(%BME688Reading{} = bme688_reading) do
    Repo.delete(bme688_reading)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bme688_reading changes.

  ## Examples

      iex> change_bme688_reading(bme688_reading)
      %Ecto.Changeset{data: %BME688Reading{}}

  """
  def change_bme688_reading(%BME688Reading{} = bme688_reading, attrs \\ %{}) do
    BME688Reading.changeset(bme688_reading, attrs)
  end

  alias ByteAir.SensorBoundary.PMS5003Reading

  @doc """
  Returns the list of pms5003readings.

  ## Examples

      iex> list_pms5003readings()
      [%PMS5003Reading{}, ...]

  """
  def list_pms5003readings do
    Repo.all(PMS5003Reading)
  end

  @doc """
  Gets a single pms5003_reading.

  Raises `Ecto.NoResultsError` if the Pms5003 reading does not exist.

  ## Examples

      iex> get_pms5003_reading!(123)
      %PMS5003Reading{}

      iex> get_pms5003_reading!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pms5003_reading!(id), do: Repo.get!(PMS5003Reading, id)

  @doc """
  Creates a pms5003_reading.

  ## Examples

      iex> create_pms5003_reading(%{field: value})
      {:ok, %PMS5003Reading{}}

      iex> create_pms5003_reading(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pms5003_reading(attrs \\ %{}) do
    %PMS5003Reading{}
    |> PMS5003Reading.changeset(attrs)
    |> Repo.insert()
    |> broadcast(:update_pms5003)
  end

  @doc """
  Updates a pms5003_reading.

  ## Examples

      iex> update_pms5003_reading(pms5003_reading, %{field: new_value})
      {:ok, %PMS5003Reading{}}

      iex> update_pms5003_reading(pms5003_reading, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pms5003_reading(%PMS5003Reading{} = pms5003_reading, attrs) do
    pms5003_reading
    |> PMS5003Reading.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pms5003_reading.

  ## Examples

      iex> delete_pms5003_reading(pms5003_reading)
      {:ok, %PMS5003Reading{}}

      iex> delete_pms5003_reading(pms5003_reading)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pms5003_reading(%PMS5003Reading{} = pms5003_reading) do
    Repo.delete(pms5003_reading)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pms5003_reading changes.

  ## Examples

      iex> change_pms5003_reading(pms5003_reading)
      %Ecto.Changeset{data: %PMS5003Reading{}}

  """
  def change_pms5003_reading(%PMS5003Reading{} = pms5003_reading, attrs \\ %{}) do
    PMS5003Reading.changeset(pms5003_reading, attrs)
  end

  defp broadcast({:error, _reason} = error, _event), do: error

  defp broadcast({:ok, pms5003_reading}, :update_pms5003) do
    Phoenix.PubSub.broadcast(ByteAir.PubSub, "pms5003_topic", {:update_pms5003, pms5003_reading})
    {:ok, pms5003_reading}
  end

  defp broadcast({:ok, bme688_reading}, :update_bme688) do
    Phoenix.PubSub.broadcast(ByteAir.PubSub, "bme688_topic", {:update_bme688, bme688_reading})
    {:ok, bme688_reading}
  end
end
