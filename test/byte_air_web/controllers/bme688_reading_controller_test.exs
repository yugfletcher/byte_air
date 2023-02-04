defmodule ByteAirWeb.BME688ReadingControllerTest do
  use ByteAirWeb.ConnCase

  import ByteAir.SensorBoundaryFixtures

  alias ByteAir.SensorBoundary.BME688Reading

  @create_attrs %{
    gas: 120.5,
    humidity: 120.5,
    name: "some name",
    pressure: 120.5,
    temperature: 120.5
  }
  @update_attrs %{
    gas: 456.7,
    humidity: 456.7,
    name: "some updated name",
    pressure: 456.7,
    temperature: 456.7
  }
  @invalid_attrs %{gas: nil, humidity: nil, name: nil, pressure: nil, temperature: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all bme688readings", %{conn: conn} do
      conn = get(conn, ~p"/api/bme688readings")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create bme688_reading" do
    test "renders bme688_reading when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/bme688readings", bme688_reading: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/bme688readings/#{id}")

      assert %{
               "id" => ^id,
               "gas" => 120.5,
               "humidity" => 120.5,
               "name" => "some name",
               "pressure" => 120.5,
               "temperature" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/bme688readings", bme688_reading: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update bme688_reading" do
    setup [:create_bme688_reading]

    test "renders bme688_reading when data is valid", %{conn: conn, bme688_reading: %BME688Reading{id: id} = bme688_reading} do
      conn = put(conn, ~p"/api/bme688readings/#{bme688_reading}", bme688_reading: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/bme688readings/#{id}")

      assert %{
               "id" => ^id,
               "gas" => 456.7,
               "humidity" => 456.7,
               "name" => "some updated name",
               "pressure" => 456.7,
               "temperature" => 456.7
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, bme688_reading: bme688_reading} do
      conn = put(conn, ~p"/api/bme688readings/#{bme688_reading}", bme688_reading: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete bme688_reading" do
    setup [:create_bme688_reading]

    test "deletes chosen bme688_reading", %{conn: conn, bme688_reading: bme688_reading} do
      conn = delete(conn, ~p"/api/bme688readings/#{bme688_reading}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/bme688readings/#{bme688_reading}")
      end
    end
  end

  defp create_bme688_reading(_) do
    bme688_reading = bme688_reading_fixture()
    %{bme688_reading: bme688_reading}
  end
end
