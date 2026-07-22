// Example: NMOS Low-Side Driver
// Goal: Switch a load with an NMOS transistor.
// Library focus: FET.MOSFET.N, RES, GPIO, DC.

module main
{
    DC.SRC PWR(5V, 200mA)
    RES R_LOAD(100R, 50V)
    RES R_GATE(100R, 50V)
    RES R_PULLDOWN(100000R, 50V)
    FET.MOSFET.N Q_SWITCH

    PWR.1 -> V5V
    PWR.2 -> GND

    V5V -> R_LOAD -> Q_SWITCH.D
    Q_SWITCH.S -> GND
    GPIO_LOAD -> R_GATE -> Q_SWITCH.G
    Q_SWITCH.G -> R_PULLDOWN -> GND
}
