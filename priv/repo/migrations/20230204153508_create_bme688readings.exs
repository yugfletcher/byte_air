defmodule ByteAir.Repo.Migrations.CreateBme688readings do
  use Ecto.Migration

  def change do
    create table(:bme688readings) do
      add :name, :string
      add :temperature, :float
      add :pressure, :float
      add :humidity, :float
      add :gas, :float

      timestamps()
    end
  end
end
