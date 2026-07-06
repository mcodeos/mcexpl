// Example: Voltage Divider
// Goal: Create a mid-supply analog output node with two resistors.
// Library focus: DC, RES.

module main
{
    DC.SRC PWR(5V, 10mA)
    RES R_TOP(10000R, 50V)
    RES R_BOTTOM(10000R, 50V)

    PWR.1 -> V5V
    PWR.2 -> GND

    V5V -> R_TOP -> VOUT
    VOUT -> R_BOTTOM -> GND
}
