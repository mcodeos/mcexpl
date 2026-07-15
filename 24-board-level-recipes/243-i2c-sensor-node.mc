// Example: I2C Sensor Node
// Goal: Combine board power, a controller, an I2C sensor, bus pull-ups, and local decoupling.
// Library focus: DC, I2C, RES, CAP.CER, HDR.

component SENSOR_NODE_MCU
{
    name = "Generic Sensor Node MCU"
    pins = [
        io 1:2 = I2C0::I2C(Master)
        ps 3 = VCC
        ps 4 = GND
    ]
}

component BOARD_I2C_SENSOR
{
    name = "Generic I2C Sensor"
    pins = [
        io 1:2 = I2C0::I2C(Slave)
        ps 3 = VCC
        ps 4 = GND
    ]
}

module main
{
    DC.SRC PWR(3.3V, 150mA)
    SENSOR_NODE_MCU U_MCU
    BOARD_I2C_SENSOR U_SENSOR
    RES R_SCL(4700R, 50V)
    RES R_SDA(4700R, 50V)
    CAP.CER C_MCU(100nF, 10V)
    CAP.CER C_SENSOR(100nF, 10V)
    HDR_1x4 J_I2C

    PWR.1 -> V3V3
    PWR.2 -> GND

    V3V3 -> U_MCU.VCC
    U_MCU.GND -> GND
    V3V3 -> U_SENSOR.VCC
    U_SENSOR.GND -> GND

    V3V3 -> C_MCU -> GND
    V3V3 -> C_SENSOR -> GND

    U_MCU.I2C0.SCL -> I2C_SCL
    U_SENSOR.I2C0.SCL -> I2C_SCL
    U_MCU.I2C0.SDA -> I2C_SDA
    U_SENSOR.I2C0.SDA -> I2C_SDA

    V3V3 -> R_SCL -> I2C_SCL
    V3V3 -> R_SDA -> I2C_SDA

    V3V3 -> J_I2C.1
    GND -> J_I2C.2
    I2C_SCL -> J_I2C.3
    I2C_SDA -> J_I2C.4
}
