// Example: Sensor Node Power File
// Goal: Provide a reusable 5 V to 3.3 V power module for a multi-file example.
// Language focus: cross-file module definition and module ports.

module SENSOR_NODE_POWER(in VIN, out V3V3, ps GND)
{
    REG.LDO U_LDO(3.3V, 500mA, 5V, 0.3V)
    CAP.CER C_IN(1uF, 10V)
    CAP.CER C_OUT(1uF, 10V)

    VIN -> U_LDO.INPUT
    U_LDO.OUTPUT -> V3V3
    U_LDO.GND -> GND
    VIN -> C_IN -> GND
    V3V3 -> C_OUT -> GND
}
