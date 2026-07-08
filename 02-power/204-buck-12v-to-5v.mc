// Example: Buck 12 V to 5 V
// Goal: Convert a 12 V input rail to a 5 V output rail.
// Library focus: REG.BUCK, IND, CAP, DC.

module main
{
    DC.SRC PWR(12V, 2A)
    REG.BUCK U_BUCK(5V, 1A, 12V, 500kHz)
    IND.POWER L_BUCK(10uH, 2A, 3A, 0.05R)
    CAP.CER C_IN(10uF, 25V)
    CAP.CER C_OUT(22uF, 10V)

    PWR.1 -> V12V
    PWR.2 -> GND
    V12V -> U_BUCK.INPUT
    U_BUCK.GND -> GND
    U_BUCK.SW -> L_BUCK -> V5V
    U_BUCK.OUTPUT -> V5V
    V5V -> U_BUCK.FB
    V12V -> C_IN -> GND
    V5V -> C_OUT -> GND
}
