// Example: Named Pins Component
// Goal: Define and instantiate a small component with readable pin names.
// Language focus: component, attributes, pins.

component TWO_PIN_SENSOR
{
    name = "Two-Pin Sensor"
    pins = [
        1 = VCC
        2 = GND
    ]
}

module main
{
    DC.SRC PWR(3.3V, 20mA)
    TWO_PIN_SENSOR U_SENSOR

    PWR.1 -> V3V3
    PWR.2 -> GND

    V3V3 -> U_SENSOR.VCC
    U_SENSOR.GND -> GND
}
