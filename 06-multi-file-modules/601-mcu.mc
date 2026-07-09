// Example: Sensor Node MCU File
// Goal: Provide an MCU component for a multi-file example.
// Language focus: cross-file component definition, interface binding.

component SENSOR_NODE_MCU
{
    name = "Sensor Node MCU"
    pins = [
        io 1:2 = I2C0::I2C(Master)
        ps 3 = VCC
        ps 4 = GND
    ]
}
