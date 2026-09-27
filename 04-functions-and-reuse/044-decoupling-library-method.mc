// Example: Decoupling Library Method
// Goal: Name each decoupling capacitor inline and wire it between its rail and GND.
// Language focus: named inline construction.

module main
{
    io GND
    io V3V3
    io V5V

    DC.SRC PWR_5V(5V, 100mA)
    DC.SRC PWR_3V3(3.3V, 100mA)

    PWR_5V.1 -> V5V
    PWR_5V.2 -> GND
    PWR_3V3.1 -> V3V3
    PWR_3V3.2 -> GND

    // Each named inline construction creates a distinct capacitor between its rail and GND.
    V5V - CAP.MLCC C_5V(100nF, 10V) - GND
    V3V3 - CAP.MLCC C_3V3(100nF, 10V) - GND
}
