// Example: Button Pull-Up
// Goal: Model a normally-high button input with a pull-up resistor.
// Library focus: SWITCH.MOM, RES, DC.

module main
{
    DC.SRC PWR(3.3V, 100mA)
    RES R_PULLUP(10000R, 50V)
    SWITCH.MOM SW_USER

    // A GPIO input would connect to the node between R_PULLUP and SW_USER.
    PWR.1 -> R_PULLUP -> SW_USER -> PWR.2
}
