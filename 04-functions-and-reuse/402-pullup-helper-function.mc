// Example: Pull-Up Helper Function
// Goal: Use a local function to create a pulled-up input node.
// Language focus: func, parameters, return.

module main
{
    DC.SRC PWR(3.3V, 50mA)
    SWITCH.MOM SW_USER

    PWR.1 -> V3V3
    PWR.2 -> GND

    func pullup_input(input, rail, ground)
    {
        RES R_PULLUP(10000R, 50V)

        rail -> R_PULLUP -> input
        input -> SW_USER.COM
        SW_USER.NO -> ground
        return input
    }

    pullup_input(BUTTON_IN, V3V3, GND)
}
