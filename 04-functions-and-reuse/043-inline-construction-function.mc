// Example: Inline Construction Function
// Goal: Name a helper component inside the method-call expression.
// Language focus: NAME::TYPE() inline construction.

component PULL_RESISTOR
{
    name = "Pull-Up Resistor"
    pins = [
        1 = INPUT
        2 = SOURCE
    ]

    func Pull([input, source])
    {
        input -> this -> source
    }
}

module main
{
    io BUTTON_IN
    io GND
    io V3V3

    DC.SRC PWR(3.3V, 50mA)
    SWITCH.MOM SW_USER

    PWR.1 -> V3V3
    PWR.2 -> GND

    R_PULL::PULL_RESISTOR().Pull([BUTTON_IN, V3V3])
    BUTTON_IN -> SW_USER.COM
    SW_USER.NO -> GND
}
