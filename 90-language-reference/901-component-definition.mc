// Reference: Component Definition
// Focus: component, name attribute, pins block, named pins.

component REF_SENSOR
{
    name = "Reference Sensor"
    pins = [
        1 = VCC
        2 = OUT
        3 = GND
    ]
}

module main
{
    DC.SRC PWR(3.3V, 20mA)
    REF_SENSOR U_SENSOR

    PWR.1 -> V3V3
    PWR.2 -> GND
    V3V3 -> U_SENSOR.VCC
    U_SENSOR.OUT -> SENSOR_OUT
    U_SENSOR.GND -> GND
}
