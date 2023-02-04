defmodule ByteAir.SensorBoundaryTest do
  use ByteAir.DataCase

  alias ByteAir.SensorBoundary

  describe "bme688readings" do
    alias ByteAir.SensorBoundary.BME688Reading

    import ByteAir.SensorBoundaryFixtures

    @invalid_attrs %{gas: nil, humidity: nil, name: nil, pressure: nil, temperature: nil}

    test "list_bme688readings/0 returns all bme688readings" do
      bme688_reading = bme688_reading_fixture()
      assert SensorBoundary.list_bme688readings() == [bme688_reading]
    end

    test "get_bme688_reading!/1 returns the bme688_reading with given id" do
      bme688_reading = bme688_reading_fixture()
      assert SensorBoundary.get_bme688_reading!(bme688_reading.id) == bme688_reading
    end

    test "create_bme688_reading/1 with valid data creates a bme688_reading" do
      valid_attrs = %{
        gas: 120.5,
        humidity: 120.5,
        name: "some name",
        pressure: 120.5,
        temperature: 120.5
      }

      assert {:ok, %BME688Reading{} = bme688_reading} =
               SensorBoundary.create_bme688_reading(valid_attrs)

      assert bme688_reading.gas == 120.5
      assert bme688_reading.humidity == 120.5
      assert bme688_reading.name == "some name"
      assert bme688_reading.pressure == 120.5
      assert bme688_reading.temperature == 120.5
    end

    test "create_bme688_reading/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SensorBoundary.create_bme688_reading(@invalid_attrs)
    end

    test "update_bme688_reading/2 with valid data updates the bme688_reading" do
      bme688_reading = bme688_reading_fixture()

      update_attrs = %{
        gas: 456.7,
        humidity: 456.7,
        name: "some updated name",
        pressure: 456.7,
        temperature: 456.7
      }

      assert {:ok, %BME688Reading{} = bme688_reading} =
               SensorBoundary.update_bme688_reading(bme688_reading, update_attrs)

      assert bme688_reading.gas == 456.7
      assert bme688_reading.humidity == 456.7
      assert bme688_reading.name == "some updated name"
      assert bme688_reading.pressure == 456.7
      assert bme688_reading.temperature == 456.7
    end

    test "update_bme688_reading/2 with invalid data returns error changeset" do
      bme688_reading = bme688_reading_fixture()

      assert {:error, %Ecto.Changeset{}} =
               SensorBoundary.update_bme688_reading(bme688_reading, @invalid_attrs)

      assert bme688_reading == SensorBoundary.get_bme688_reading!(bme688_reading.id)
    end

    test "delete_bme688_reading/1 deletes the bme688_reading" do
      bme688_reading = bme688_reading_fixture()
      assert {:ok, %BME688Reading{}} = SensorBoundary.delete_bme688_reading(bme688_reading)

      assert_raise Ecto.NoResultsError, fn ->
        SensorBoundary.get_bme688_reading!(bme688_reading.id)
      end
    end

    test "change_bme688_reading/1 returns a bme688_reading changeset" do
      bme688_reading = bme688_reading_fixture()
      assert %Ecto.Changeset{} = SensorBoundary.change_bme688_reading(bme688_reading)
    end
  end

  describe "pms5003readings" do
    alias ByteAir.SensorBoundary.PMS5003Reading

    import ByteAir.SensorBoundaryFixtures

    @invalid_attrs %{name: nil, pm10: nil, pm1_0: nil, pm2_5: nil}

    test "list_pms5003readings/0 returns all pms5003readings" do
      pms5003_reading = pms5003_reading_fixture()
      assert SensorBoundary.list_pms5003readings() == [pms5003_reading]
    end

    test "get_pms5003_reading!/1 returns the pms5003_reading with given id" do
      pms5003_reading = pms5003_reading_fixture()
      assert SensorBoundary.get_pms5003_reading!(pms5003_reading.id) == pms5003_reading
    end

    test "create_pms5003_reading/1 with valid data creates a pms5003_reading" do
      valid_attrs = %{name: "some name", pm10: 42, pm1_0: 42, pm2_5: 42}

      assert {:ok, %PMS5003Reading{} = pms5003_reading} =
               SensorBoundary.create_pms5003_reading(valid_attrs)

      assert pms5003_reading.name == "some name"
      assert pms5003_reading.pm10 == 42
      assert pms5003_reading.pm1_0 == 42
      assert pms5003_reading.pm2_5 == 42
    end

    test "create_pms5003_reading/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SensorBoundary.create_pms5003_reading(@invalid_attrs)
    end

    test "update_pms5003_reading/2 with valid data updates the pms5003_reading" do
      pms5003_reading = pms5003_reading_fixture()
      update_attrs = %{name: "some updated name", pm10: 43, pm1_0: 43, pm2_5: 43}

      assert {:ok, %PMS5003Reading{} = pms5003_reading} =
               SensorBoundary.update_pms5003_reading(pms5003_reading, update_attrs)

      assert pms5003_reading.name == "some updated name"
      assert pms5003_reading.pm10 == 43
      assert pms5003_reading.pm1_0 == 43
      assert pms5003_reading.pm2_5 == 43
    end

    test "update_pms5003_reading/2 with invalid data returns error changeset" do
      pms5003_reading = pms5003_reading_fixture()

      assert {:error, %Ecto.Changeset{}} =
               SensorBoundary.update_pms5003_reading(pms5003_reading, @invalid_attrs)

      assert pms5003_reading == SensorBoundary.get_pms5003_reading!(pms5003_reading.id)
    end

    test "delete_pms5003_reading/1 deletes the pms5003_reading" do
      pms5003_reading = pms5003_reading_fixture()
      assert {:ok, %PMS5003Reading{}} = SensorBoundary.delete_pms5003_reading(pms5003_reading)

      assert_raise Ecto.NoResultsError, fn ->
        SensorBoundary.get_pms5003_reading!(pms5003_reading.id)
      end
    end

    test "change_pms5003_reading/1 returns a pms5003_reading changeset" do
      pms5003_reading = pms5003_reading_fixture()
      assert %Ecto.Changeset{} = SensorBoundary.change_pms5003_reading(pms5003_reading)
    end
  end
end
