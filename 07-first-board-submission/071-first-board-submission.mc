// The board this chapter runs: one 5 V source, a divider that makes a
// measurement point, and a load that draws on the rail.
//
// It is the smallest board that carries a claim. A leaderboard project
// wraps exactly this shape in a contract: the circuit above is the ideal
// context, the claims below are what the board is judged on.
module main {
    io GND
    io V5V
    io VOUT

    // The source: 5 V in, the rail everything else hangs off.
    DC.SRC PWR(5V, 500mA)
    PWR.1 -> V5V
    PWR.2 -> GND

    // The divider: the measurement point the claim reads.
    RES R_TOP(2kOhm, 50V)
    RES R_BOTTOM(1kOhm, 50V)
    V5V -> R_TOP.1
    R_TOP.2 -> VOUT
    VOUT -> R_BOTTOM.1
    R_BOTTOM.2 -> GND

    // The bulk capacitor on the rail, and the load that draws on it.
    CAP C_BULK(10uF, 10V)
    V5V -> C_BULK.1
    C_BULK.2 -> GND

    RES R_LOAD(1kOhm, 50V)
    V5V -> R_LOAD.1
    R_LOAD.2 -> GND
}
