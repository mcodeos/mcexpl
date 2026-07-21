// Example: Buck Module 12 V to 5 V
// Goal: Treat a complete buck module as a three-terminal regulator block.
// Library focus: REG, CAP, DC.

module main
{
    DC.SRC PWR(12V, 2A)
    REG U_BUCK_MODULE(5V, 1A, 12V)
    CAP.CER C_IN(10uF, 25V)
    CAP.CER C_OUT(22uF, 10V)

    PWR.1 -> V12V
    PWR.2 -> GND
    V12V -> U_BUCK_MODULE.INPUT
    U_BUCK_MODULE.OUTPUT -> V5V
    U_BUCK_MODULE.GND -> GND
    V12V -> C_IN -> GND
    V5V -> C_OUT -> GND
}
