// Example: Multi-File Sensor Node
// Goal: Import local files and connect a small sensor node.
// Language focus: use, cross-file project reuse.

// Each use path is resolved relative to this entry file.
use ./power.mc
use ./mcu.mc
use ./sensor.mc

module main
{
    SENSOR_NODE_POWER U_POWER
    SENSOR_NODE_MCU U_MCU
    I2C_TEMP_SENSOR U_SENSOR
    RES R_SCL(4700R, 50V)
    RES R_SDA(4700R, 50V)

    VIN -> U_POWER.VIN
    U_POWER.V3V3 -> V3V3
    U_POWER.GND -> GND

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
