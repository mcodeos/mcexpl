// Example: Decoupling Library Method
// Goal: Reuse the capacitor library's connection method on two rails.
// Language focus: library component methods.

module main
{
    DC.SRC PWR_5V(5V, 100mA)
    DC.SRC PWR_3V3(3.3V, 100mA)

    PWR_5V.1 -> V5V
    PWR_5V.2 -> GND
    PWR_3V3.1 -> V3V3
    PWR_3V3.2 -> GND

    // Each call creates a distinct capacitor between its rail and GND.
    C_5V::CAP.CER(100nF, 10V).Cap(V5V, GND)
    C_3V3::CAP.CER(100nF, 10V).Cap(V3V3, GND)
}
