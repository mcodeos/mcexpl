// Example: Resistor LED
// Goal: Show a simple LED indicator with a current-limiting resistor.
// Library focus: RES, LED, DC.

module main
{
    DC.SRC PWR(5V, 500mA)
    RES R_LIMIT(330R, 50V)
    LED D_STATUS(2.0V, 20mA)

    PWR.1 -> R_LIMIT -> D_STATUS -> PWR.2
}
