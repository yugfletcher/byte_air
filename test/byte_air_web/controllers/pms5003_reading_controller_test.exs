defmodule ByteAirWeb.PMS5003ReadingControllerTest do
  use ByteAirWeb.ConnCase

  import ByteAir.SensorBoundaryFixtures

  alias ByteAir.SensorBoundary.PMS5003Reading

  @create_attrs %{
    name: "some name",
    pm10: 42,
    pm1_0: 42,
    pm2_5: 42
  }
  @update_attrs %{
    name: "some updated name",
    pm10: 43,
    pm1_0: 43,
    pm2_5: 43
  }
  @invalid_attrs %{name: nil, pm10: nil, pm1_0: nil, pm2_5: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all pms5003readings", %{conn: conn} do
      conn = get(conn, ~p"/api/pms5003readings")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create pms5003_reading" do
    test "renders pms5003_reading when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/pms5003readings", pms5003_reading: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/pms5003readings/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some name",
               "pm10" => 42,
               "pm1_0" => 42,
               "pm2_5" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/pms5003readings", pms5003_reading: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update pms5003_reading" do
    setup [:create_pms5003_reading]

    test "renders pms5003_reading when data is valid", %{conn: conn, pms5003_reading: %PMS5003Reading{id: id} = pms5003_reading} do
      conn = put(conn, ~p"/api/pms5003readings/#{pms5003_reading}", pms5003_reading: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/pms5003readings/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some updated name",
               "pm10" => 43,
               "pm1_0" => 43,
               "pm2_5" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, pms5003_reading: pms5003_reading} do
      conn = put(conn, ~p"/api/pms5003readings/#{pms5003_reading}", pms5003_reading: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete pms5003_reading" do
    setup [:create_pms5003_reading]

    test "deletes chosen pms5003_reading", %{conn: conn, pms5003_reading: pms5003_reading} do
      conn = delete(conn, ~p"/api/pms5003readings/#{pms5003_reading}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/pms5003readings/#{pms5003_reading}")
      end
    end
  end

  defp create_pms5003_reading(_) do
    pms5003_reading = pms5003_reading_fixture()
    %{pms5003_reading: pms5003_reading}
  end
end
