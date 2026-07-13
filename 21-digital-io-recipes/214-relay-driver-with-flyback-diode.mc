// Example: Relay Driver With Flyback Diode
// Goal: Drive a relay coil and add flyback protection.
// Library focus: RELAY, MOSFET.NMOS, DIO, RES, DC.

module main
{
    DC.SRC PWR(5V, 500mA)
    RELAY K_LOAD(1A, 5V)
    MOSFET.NMOS Q_RELAY
    RES R_GATE(100R, 50V)
    RES R_PULLDOWN(100000R, 50V)
    DIO D_FLYBACK(0.7V, 100V, 1A)

    PWR.1 -> V5V
    PWR.2 -> GND

    V5V -> K_LOAD.COIL.VCC
    K_LOAD.COIL.GND -> COIL_LOW
    COIL_LOW -> Q_RELAY.D
    Q_RELAY.S -> GND

    GPIO_RELAY -> R_GATE -> Q_RELAY.G
    Q_RELAY.G -> R_PULLDOWN -> GND

    COIL_LOW -> D_FLYBACK.ANODE
    D_FLYBACK.CATHODE -> V5V
}
