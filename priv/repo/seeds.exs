# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ByteAir.Repo.insert!(%ByteAir.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
# ByteAir.Repo.insert!(%ByteAir.)
ByteAir.Repo.insert!(%ByteAir.SensorBoundary.BME688Reading{name: "pog", temperature: 20.0, pressure: 125.0, humidity: 14.0, gas: 17.3})
ByteAir.Repo.insert!(%ByteAir.SensorBoundary.PMS5003Reading{name: "yugg", pm10: 5, pm1_0: 9, pm2_5: 8})