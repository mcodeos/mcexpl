// Example: Pull-Up Helper Function
// Goal: Return the named input node from a reusable pull-up method.
// Language focus: return values from component methods.

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
    PULLUP_RESISTOR R_PULLUP
    SWITCH.MOM SW_USER

    PWR.1 -> V3V3
    PWR.2 -> GND

    R_PULLUP.Pullup(BUTTON_IN, V3V3)
    // Repeating BUTTON_IN makes the shared input node explicit.
    BUTTON_IN -> SW_USER.COM
    SW_USER.NO -> GND
}
