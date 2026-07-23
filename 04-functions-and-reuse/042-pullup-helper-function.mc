// Example: Pull-Up Helper Function
// Goal: Configure both channels of a pull-up network in one method chain.
// Language focus: named pins in methods, return this, chained method calls.

component DUAL_PULLUP_RESISTOR
{
    name = "Dual Pull-Up Resistor"
    pins = [
        1 = INPUT_A
        2 = SOURCE_A
        3 = INPUT_B
        4 = SOURCE_B
    ]

    func PullupA(input, source, switch_pin)
    {
        input -> INPUT_A
        SOURCE_A -> source
        input -> switch_pin
        return this
    }

    func PullupB(input, source, switch_pin)
    {
        input -> INPUT_B
        SOURCE_B -> source
        input -> switch_pin
    }
}

module main
{
    DC.SRC PWR(3.3V, 50mA)
    DUAL_PULLUP_RESISTOR RN_PULLUPS
    SWITCH.MOM SW_A
    SWITCH.MOM SW_B

    PWR.1 -> V3V3
    PWR.2 -> GND

    RN_PULLUPS.PullupA(BUTTON_A, V3V3, SW_A.COM).PullupB(BUTTON_B, V3V3, SW_B.COM)
    SW_A.NO -> GND
    SW_B.NO -> GND
}
