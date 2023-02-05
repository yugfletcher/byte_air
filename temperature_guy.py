"""BME688 / BME680 demo

This demo will work for both the BME680 and BME688.
"""
import time
import network
import urequests
import ujson
from picographics import PicoGraphics, DISPLAY_ENVIRO_PLUS
from pimoroni import RGBLED
from breakout_bme68x import BreakoutBME68X, STATUS_HEATER_STABLE
from pimoroni_i2c import PimoroniI2C

PINS_BREAKOUT_GARDEN = {"sda": 4, "scl": 5}
PINS_PICO_EXPLORER = {"sda": 20, "scl": 21}

i2c = PimoroniI2C(**PINS_BREAKOUT_GARDEN)
bmp = BreakoutBME68X(i2c, address=0x77)

led = RGBLED(6, 7, 10, invert=True)  # setting pins for the RGB led
led.set_rgb(0, 0, 0)

# this gets us on the internet
wlan = network.WLAN(network.STA_IF)
wlan.active(True)
wlan.connect('phone', 'asdfghjkl')

while True:
    temperature, pressure, humidity, gas, status, _, _ = bmp.read()
    heater = "Stable" if status & STATUS_HEATER_STABLE else "Unstable"
    
    payload = ujson.dumps({
        "bme688_reading": {
            "name": "pogchamp",
            "temperature": temperature,
            "pressure": pressure,
            "humidity": humidity,
            "gas": gas
        }
    })
    headers = {
        'Content-Type': 'application/json'
    }
    
    url = "https://byte-air.fly.dev/api/bme688readings"

    r = urequests.request("POST", url, headers=headers, data=payload)
    r.close()
