// Example: Photodiode Input
// Goal: Model a simple reverse-biased photodiode with a load resistor.
// Library focus: DC, DIO.PHO, RES.

module main
{
    DC.SRC PWR(3.3V, 1mA)
    DIO.PHO D_LIGHT(0.5A/W, 1nA, 850nm)
    RES R_LOAD(100000R, 50V)

    PWR.1 -> V3V3
    PWR.2 -> GND

    V3V3 -> D_LIGHT.CATHODE
    D_LIGHT.ANODE -> LIGHT_SENSE
    LIGHT_SENSE -> R_LOAD -> GND
}
