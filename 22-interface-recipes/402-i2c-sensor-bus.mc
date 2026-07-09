// Example: I2C Sensor Bus
// Goal: Connect an I2C controller to a sensor-side bus.
// Library focus: I2C, RES, DC.

component MCU_I2C
{
    name = "MCU with I2C"
    pins = [
        io 1:2 = I2C0::I2C(Master)
        3 = VCC
        4 = GND
    ]
}

component SENSOR_I2C
{
    name = "I2C Sensor"
    pins = [
        io 1:2 = I2C0::I2C(Slave)
        3 = VCC
        4 = GND
    ]
}

module main
{
    DC.SRC PWR(3.3V, 100mA)
    MCU_I2C U_MCU
    SENSOR_I2C U_SENSOR
    RES R_SCL(4700R, 50V)
    RES R_SDA(4700R, 50V)

    PWR.1 -> V3V3
    PWR.2 -> GND

    V3V3 -> U_MCU.VCC
    V3V3 -> U_SENSOR.VCC
    U_MCU.GND -> GND
    U_SENSOR.GND -> GND

    U_MCU.I2C0.SCL -> I2C_SCL
    U_SENSOR.I2C0.SCL -> I2C_SCL
    U_MCU.I2C0.SDA -> I2C_SDA
    U_SENSOR.I2C0.SDA -> I2C_SDA

    V3V3 -> R_SCL -> I2C_SCL
    V3V3 -> R_SDA -> I2C_SDA
}
