// Reference: Inline Construction And Library Methods
// Focus: NAME::TYPE(args) plus a method provided by the mcode library.

module main
{
    DC.SRC PWR(3.3V, 20mA)
    SWITCH.MOM SW_USER

    PWR.1 -> V3V3
    PWR.2 -> GND

    R_PULLUP::RES(10000R, 50V).Pullup(BUTTON_IN, V3V3)
    BUTTON_IN -> SW_USER.COM
    SW_USER.NO -> GND
}
