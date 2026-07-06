// Example: Diode Rectifier
// Goal: Use a diode to define one-way current flow.
// Library focus: DIO, RES.

module main
{
    DIO D_RECT(0.7V, 100V, 1A)
    RES R_LOAD(1000R, 50V)

    VIN -> D_RECT.ANODE
    D_RECT.CATHODE -> VRECT
    VRECT -> R_LOAD -> GND
}
