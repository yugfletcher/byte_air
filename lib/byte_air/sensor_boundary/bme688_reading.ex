defmodule ByteAir.SensorBoundary.BME688Reading do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bme688readings" do
    field :gas, :float
    field :humidity, :float
    field :name, :string
    field :pressure, :float
    field :temperature, :float

    timestamps()
  end

  @doc false
  def changeset(bme688_reading, attrs) do
    bme688_reading
    |> cast(attrs, [:name, :temperature, :pressure, :humidity, :gas])
    |> validate_required([:name, :temperature, :pressure, :humidity, :gas])
  end
end
