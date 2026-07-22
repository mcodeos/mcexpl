// Example: Inline Construction Function
// Goal: Name a helper component inside the method-call expression.
// Language focus: NAME::TYPE() inline construction.

component PULLUP_RESISTOR
{
    name = "Pull-Up Resistor"
    pins = [
        1 = INPUT
        2 = SOURCE
    ]

    func Pullup(input, source)
    {
        input -> this -> source
        return input
    }
}

module main
{
    DC.SRC PWR(3.3V, 50mA)
    SWITCH.MOM SW_USER

    PWR.1 -> V3V3
    PWR.2 -> GND

    R_PULLUP::PULLUP_RESISTOR().Pullup(BUTTON_IN, V3V3)
    BUTTON_IN -> SW_USER.COM
    SW_USER.NO -> GND
}
