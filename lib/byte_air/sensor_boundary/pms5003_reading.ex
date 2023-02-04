defmodule ByteAir.SensorBoundary.PMS5003Reading do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pms5003readings" do
    field :name, :string
    field :pm10, :integer
    field :pm1_0, :integer
    field :pm2_5, :integer

    timestamps()
  end

  @doc false
  def changeset(pms5003_reading, attrs) do
    pms5003_reading
    |> cast(attrs, [:name, :pm1_0, :pm2_5, :pm10])
    |> validate_required([:name, :pm1_0, :pm2_5, :pm10])
  end
end
