// Example: TVS Input Protection
// Goal: Protect an external input from voltage transients.
// Library focus: DIO.TVS, RES.

module main
{
    RES R_INPUT(100R, 50V)
    DIO.TVS D_PROTECT(6V, 12V, 600W)

    INPUT_EXT -> R_INPUT -> INPUT_PROTECTED
    INPUT_PROTECTED -> D_PROTECT.CATHODE
    D_PROTECT.ANODE -> GND
}
