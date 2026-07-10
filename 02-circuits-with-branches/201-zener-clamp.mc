// Example: Zener Clamp Branch
// Goal: Add a clamp branch from a protected node to ground.
// Library focus: DIO.ZEN, RES.

module main
{
    RES R_SERIES(1000R, 50V)
    DIO.ZEN Z_CLAMP(5.1V, 0.5W, 5%)

    VIN -> R_SERIES -> VCLAMP
    // Reusing VCLAMP starts a second path from the protected node.
    VCLAMP -> Z_CLAMP.CATHODE
    Z_CLAMP.ANODE -> GND
}
