// Example: Battery Input
// Goal: Represent a battery as the source for a board.
// Library focus: DC.BAT, FUSE, DIO.SCH, CAP.

module main
{
    DC.BAT BAT(3.7V, 1000uF)
    FUSE F_BAT(1A, 12V)
    DIO.SCH D_REVERSE(0.3V, 40V, 2A)
    CAP.ELEC C_BULK(100uF, 10V)

    BAT.1 -> F_BAT -> D_REVERSE.ANODE
    D_REVERSE.CATHODE -> VBAT_PROTECTED
    VBAT_PROTECTED -> C_BULK -> GND
    BAT.2 -> GND
}
