// Example: RC Low-Pass Filter
// Goal: Filter a signal with a series resistor and a shunt capacitor.
// Library focus: RES, CAP.

module main
{
    RES R_FILTER(1000R, 50V)
    CAP C_FILTER(100nF, 16V)

    VIN -> R_FILTER -> VOUT
    VOUT -> C_FILTER -> GND
}
