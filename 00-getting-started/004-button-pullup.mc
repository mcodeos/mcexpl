// Example: Button Pull-Up
// Goal: Model a normally-high button input with a pull-up resistor.
// Library focus: SWITCH.MOM, RES, DC.

module main
{
    DC.SRC PWR(3.3V, 100mA)
    RES R_PULLUP(10000R, 50V)
    SWITCH.MOM SW_USER

    PWR.1 -> V3V3
    PWR.2 -> GND

    // BUTTON_IN is high normally and is connected to ground when pressed.
    V3V3 -> R_PULLUP -> BUTTON_IN
    BUTTON_IN -> SW_USER.COM
    SW_USER.NO -> GND
}
