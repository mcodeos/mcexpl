// Example: Power Tree 5 V, 3.3 V, 1.8 V
// Goal: Show a small multi-rail power structure.
// Library focus: REG, CAP, DC.

use mclibs.power/reg.mc

module main
{
    io GND
    io V1V8
    io V3V3
    io V5V

    DC.SRC PWR(5V, 1A)
    REG.LDO U_3V3(3.3V, 0.5A, 5V, 0.3V)
    REG.LDO U_1V8(1.8V, 0.3A, 3.3V, 0.2V)
    CAP.MLCC C_5V(10uF, 10V)
    CAP.MLCC C_3V3(4.7uF, 6.3V)
    CAP.MLCC C_1V8(4.7uF, 6.3V)

    PWR.1 -> V5V
    PWR.2 -> GND
    V5V -> C_5V -> GND
    V5V -> U_3V3.Vin
    U_3V3.Vout -> V3V3
    U_3V3.GND -> GND
    V3V3 -> C_3V3 -> GND
    V3V3 -> U_1V8.Vin
    U_1V8.Vout -> V1V8
    U_1V8.GND -> GND
    V1V8 -> C_1V8 -> GND
}
