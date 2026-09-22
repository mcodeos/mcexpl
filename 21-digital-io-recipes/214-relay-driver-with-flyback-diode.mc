// Example: Relay Driver With Flyback Diode
// Goal: Drive a relay coil and add flyback protection.
// Library focus: RELAY, FET.MOSFET.N, DIO, RES, DC.

module main
{
    io COIL_LOW
    io GND
    io GPIO_RELAY
    io V5V

    DC.SRC PWR(5V, 500mA)
    RELAY K_LOAD(1A, 5V)
    FET.MOSFET.N Q_RELAY
    RES R_GATE(100R, 50V)
    RES R_PULLDOWN(100000R, 50V)
    DIO D_FLYBACK(0.7V, 100V, 1A)

    PWR.1 -> V5V
    PWR.2 -> GND

    V5V -> K_LOAD.COIL.VCC
    K_LOAD.COIL.GND -> COIL_LOW
    COIL_LOW -> Q_RELAY.DRAIN
    Q_RELAY.SOURCE -> GND

    GPIO_RELAY -> R_GATE -> Q_RELAY.GATE
    Q_RELAY.GATE -> R_PULLDOWN -> GND

    COIL_LOW -> D_FLYBACK.ANODE
    D_FLYBACK.CATHODE -> V5V
}
