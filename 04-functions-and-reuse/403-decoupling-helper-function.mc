// Example: Decoupling Helper Function
// Goal: Reuse the capacitor library's connection method on two rails.
// Language focus: repeated component method calls.

module main
{
    DC.SRC PWR(5V, 500mA)
    REG.LDO U_LDO(3.3V, 0.2A, 5V, 0.3V)
    PWR.1 -> V5V
    PWR.2 -> GND
    V5V -> U_LDO.INPUT
    U_LDO.OUTPUT -> V3V3
    U_LDO.GND -> GND

    // Each call creates a distinct capacitor between its rail and GND.
    C_5V::CAP.CER(100nF, 10V).Cap(V5V, GND)
    C_3V3::CAP.CER(100nF, 10V).Cap(V3V3, GND)
}
