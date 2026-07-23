// Example: Sensor Node Sensor File
// Goal: Provide an I2C sensor component for a multi-file example.
// Language focus: cross-file component definition, interface binding.

component I2C_TEMP_SENSOR
{
    name = "I2C Temperature Sensor"
    pins = [
        io [1:2] = I2C0::I2C(Slave)
        ps 3 = VCC
        ps 4 = GND
    ]
}
