// Example: Decoupling Capacitor
// Goal: Place a capacitor between a supply rail and ground.
// Library focus: CAP, DC.

module main
{
    DC.SRC PWR(3.3V, 500mA)
    CAP C_DEC(100nF, 10V)

    PWR.1 -> C_DEC -> PWR.2
}
