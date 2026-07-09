// Example: LDO 5 V to 3.3 V
// Goal: Convert a 5 V rail to a 3.3 V rail with an LDO.
// Library focus: REG.LDO, CAP, DC.

module main
{
    DC.SRC PWR(5V, 1A)
    REG.LDO U_LDO(3.3V, 0.5A, 5V, 0.3V)
    CAP.CER C_IN(1uF, 10V)
    CAP.CER C_OUT(1uF, 6.3V)

    PWR.1 -> V5V
    PWR.2 -> GND
    V5V -> U_LDO.INPUT
    U_LDO.OUTPUT -> V3V3
    U_LDO.GND -> GND
    V5V -> C_IN -> GND
    V3V3 -> C_OUT -> GND
}
