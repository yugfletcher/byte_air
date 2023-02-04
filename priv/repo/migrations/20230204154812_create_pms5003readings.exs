defmodule ByteAir.Repo.Migrations.CreatePms5003readings do
  use Ecto.Migration

  def change do
    create table(:pms5003readings) do
      add :name, :string
      add :pm1_0, :integer
      add :pm2_5, :integer
      add :pm10, :integer

      timestamps()
    end
  end
end
