// Reference: Named Inline Construction
// Focus: TYPE name(args) inline construction with the mcode library parts.

module main
{
    io BUTTON_IN
    io GND
    io V3V3

    DC.SRC PWR(3.3V, 20mA)
    SWITCH.MOM SW_USER

    PWR.1 -> V3V3
    PWR.2 -> GND

    BUTTON_IN - RES R_PULLUP(10000R, 50V) - V3V3
    BUTTON_IN -> SW_USER.COM
    SW_USER.NO -> GND
}
