// Example: Button Input
// Goal: Connect a momentary switch to a digital input.
// Library focus: SWITCH.MOM, RES, GPIO, DC.

module main
{
    DC.SRC PWR(3.3V, 20mA)
    RES R_PULLUP(10000R, 50V)
    SWITCH.MOM SW_USER

    PWR.1 -> V3V3
    PWR.2 -> GND

    V3V3 -> R_PULLUP -> BUTTON_IN
    BUTTON_IN -> SW_USER.COM
    SW_USER.NO -> GND
}
